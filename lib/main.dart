import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'data/api_client.dart';
import 'data/pos_database.dart';

const green = Color(0xFF155F4B);
const orange = Color(0xFFE78A24);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PosApp(database: PosDatabase(), api: ApiClient()));
}

class PosApp extends StatelessWidget {
  const PosApp({super.key, required this.database, required this.api});
  final PosDatabase database;
  final ApiClient api;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'La Salvajada POS',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: green, primary: green),
      scaffoldBackgroundColor: const Color(0xFFF7F4EF),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEAE3D8)),
        ),
      ),
    ),
    home: Gate(database: database, api: api),
  );
}

class Gate extends StatefulWidget {
  const Gate({super.key, required this.database, required this.api});
  final PosDatabase database;
  final ApiClient api;
  @override
  State<Gate> createState() => _GateState();
}

class _GateState extends State<Gate> {
  bool? signedIn;
  @override
  void initState() {
    super.initState();
    widget.api.token.then((value) {
      if (mounted) setState(() => signedIn = value != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signedIn == null)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return signedIn!
        ? Shell(
            database: widget.database,
            api: widget.api,
            onLogout: () => setState(() => signedIn = false),
          )
        : Login(
            database: widget.database,
            api: widget.api,
            onLogin: () => setState(() => signedIn = true),
          );
  }
}

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.database,
    required this.api,
    required this.onLogin,
  });
  final PosDatabase database;
  final ApiClient api;
  final VoidCallback onLogin;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final name = TextEditingController(text: 'admin');
  final pin = TextEditingController();
  bool busy = false;
  String? error;
  Future<void> submit() async {
    setState(() => busy = true);
    error = null;
    try {
      final user = await widget.api.login(name.text, pin.text);
      await widget.database
          .into(widget.database.localSettings)
          .insertOnConflictUpdate(
            LocalSettingsCompanion.insert(
              key: 'user_id',
              value: user['user_id'].toString(),
            ),
          );
      widget.onLogin();
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  void dispose() {
    name.dispose();
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/logo.png',
                        height: 145,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Punto de venta',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const Text('Pedidos, caja e inventario desde el celular.'),
                    const SizedBox(height: 22),
                    TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: pin,
                      obscureText: true,
                      onSubmitted: (_) => submit(),
                      decoration: const InputDecoration(
                        labelText: 'Contraseña o PIN',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: busy ? null : submit,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(busy ? 'Ingresando…' : 'Ingresar'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Las operaciones quedan guardadas en el teléfono cuando no hay internet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class Shell extends StatefulWidget {
  const Shell({
    super.key,
    required this.database,
    required this.api,
    required this.onLogout,
  });
  final PosDatabase database;
  final ApiClient api;
  final VoidCallback onLogout;
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  late final SyncCoordinator sync = SyncCoordinator(widget.api, widget.database)
    ..start();
  int index = 0;
  String role = 'CAJERO';
  bool online = false;
  String? refreshError;
  @override
  void initState() {
    super.initState();
    widget.api.role.then((v) {
      if (mounted) setState(() => role = v ?? 'CAJERO');
    });
    refresh();
  }

  Future<void> refresh() async {
    try {
      await widget.api.dashboard();
      if (mounted) {
        setState(() {
          online = true;
          refreshError = null;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          online = false;
          refreshError = error.toString();
        });
      }
      return;
    }

    var section = 'sincronización de operaciones';
    try {
      await sync.syncNow();
      section = 'catálogo';
      await widget.database.cacheCatalog(await widget.api.catalog());
      section = 'pedidos';
      await widget.database.saveOrders(await widget.api.orders());
      section = 'inventario';
      await widget.database.cacheIngredients(await widget.api.inventory());
      if (mounted) setState(() => refreshError = null);
    } catch (error) {
      if (mounted) {
        setState(() {
          online = true;
          refreshError =
              'Worker conectado; no se pudo actualizar $section: $error';
        });
      }
    }
  }

  @override
  void dispose() {
    sync.dispose();
    widget.api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      Home(
        database: widget.database,
        api: widget.api,
        online: online,
        refreshError: refreshError,
        onRefresh: refresh,
      ),
      Orders(
        database: widget.database,
        api: widget.api,
        sync: sync,
        onRefresh: refresh,
      ),
      Reports(api: widget.api, database: widget.database, sync: sync),
      Cash(database: widget.database, api: widget.api, sync: sync),
      More(
        database: widget.database,
        api: widget.api,
        sync: sync,
        role: role,
        onRefresh: refresh,
        onLogout: widget.onLogout,
      ),
    ];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.space_dashboard_outlined),
            selectedIcon: Icon(Icons.space_dashboard),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Ventas',
          ),
          NavigationDestination(
            icon: Icon(Icons.point_of_sale_outlined),
            selectedIcon: Icon(Icons.point_of_sale),
            label: 'Caja',
          ),
          NavigationDestination(icon: Icon(Icons.more_horiz), label: 'Más'),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.database,
    required this.api,
    required this.online,
    required this.refreshError,
    required this.onRefresh,
  });
  final PosDatabase database;
  final ApiClient api;
  final bool online;
  final String? refreshError;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Image.asset('assets/logo.png', width: 34, height: 34),
          const SizedBox(width: 8),
          const Text('La Salvajada'),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Chip(
            avatar: Icon(
              online ? Icons.cloud_done : Icons.cloud_off,
              size: 16,
              color: online ? green : orange,
            ),
            label: Text(online ? 'En línea' : 'Offline'),
          ),
        ),
      ],
    ),
    body: RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          if (refreshError != null)
            Card(
              color: const Color(0xFFFFF1E8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(refreshError!),
              ),
            ),
          Text(
            'Resumen de hoy',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          FutureBuilder<Map<String, dynamic>>(
            future: api.dashboard(),
            builder: (context, s) {
              final income =
                  s.data?['income'] as Map<String, dynamic>? ?? const {};
              final orders =
                  s.data?['orders'] as Map<String, dynamic>? ?? const {};
              final alerts =
                  s.data?['alerts'] as List<dynamic>? ?? const <dynamic>[];
              return Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 9,
                    mainAxisSpacing: 9,
                    children: [
                      Metric(
                        title: 'Ingresos de hoy',
                        value: cash(income['total']),
                        icon: Icons.payments,
                        color: green,
                      ),
                      Metric(
                        title: 'Recibidos',
                        value: (orders['recibidos'] ?? 0).toString(),
                        icon: Icons.inbox,
                        color: Colors.blue,
                      ),
                      Metric(
                        title: 'Terminados',
                        value: (orders['terminados'] ?? 0).toString(),
                        icon: Icons.done_all,
                        color: orange,
                      ),
                      Metric(
                        title: 'Entregados',
                        value: (orders['entregados'] ?? 0).toString(),
                        icon: Icons.delivery_dining,
                        color: green,
                      ),
                    ],
                  ),
                  if (alerts.isNotEmpty)
                    Card(
                      color: const Color(0xFFFFF1E8),
                      child: ExpansionTile(
                        leading: const Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.deepOrange,
                        ),
                        title: Text(
                          '${alerts.length} insumos con existencia baja',
                        ),
                        children: alerts.map((item) {
                          final row = item as Map<String, dynamic>;
                          return ListTile(
                            title: Text(row['name'].toString()),
                            trailing: Text(
                              '${row['quantity']} ${row['unit']} · mín. ${row['minimum']}',
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          StreamBuilder<int>(
            stream: database.watchPendingCount(),
            builder: (context, s) => Card(
              child: ListTile(
                leading: const Icon(Icons.sync, color: orange),
                title: Text(
                  (s.data ?? 0) == 0
                      ? 'Todo sincronizado'
                      : (s.data ?? 0).toString() + ' operaciones pendientes',
                ),
                subtitle: const Text(
                  'Los datos permanecen en el teléfono hasta sincronizar.',
                ),
                trailing: IconButton(
                  onPressed: () => syncNow(context),
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ),
          ),
          StreamBuilder<List<SyncOutboxData>>(
            stream: database.watchSyncErrors(),
            builder: (context, s) {
              final errors = s.data ?? const <SyncOutboxData>[];
              if (errors.isEmpty) return const SizedBox.shrink();
              return Card(
                color: const Color(0xFFFFF1E8),
                child: ExpansionTile(
                  leading: const Icon(
                    Icons.warning_amber,
                    color: Colors.deepOrange,
                  ),
                  title: Text(
                    '${errors.length} operaciones necesitan atención',
                  ),
                  children: errors
                      .map(
                        (event) => ListTile(
                          title: Text(event.eventType),
                          subtitle: Text(
                            event.lastError ?? 'No se pudo sincronizar',
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
          FutureBuilder<LocalShift?>(
            future: database.getOpenShift(),
            builder: (context, s) => Card(
              child: ListTile(
                leading: const Icon(Icons.point_of_sale, color: green),
                title: Text(s.data == null ? 'Turno cerrado' : 'Turno abierto'),
                subtitle: Text(
                  s.data == null
                      ? 'Abre caja en la pestaña Caja.'
                      : 'Base: ' + cash(s.data!.openingCash),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pedidos recientes',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          StreamBuilder<List<CachedOrder>>(
            stream: database.watchOrders(),
            builder: (context, s) {
              final rows = (s.data ?? const <CachedOrder>[])
                  .where((order) => order.status != 'ENTREGADO')
                  .take(5)
                  .toList();
              if (rows.isEmpty) {
                return const EmptyCard('Los pedidos aparecerán aquí.');
              }
              return Column(
                children: rows.map((row) => OrderCard(order: row)).toList(),
              );
            },
          ),
        ],
      ),
    ),
  );
  Future<void> syncNow(BuildContext context) async {
    try {
      await api.sync(database);
      await onRefresh();
    } catch (e) {
      if (context.mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

class Metric extends StatelessWidget {
  const Metric({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String title, value;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class Orders extends StatelessWidget {
  const Orders({
    super.key,
    required this.database,
    required this.api,
    required this.sync,
    required this.onRefresh,
  });
  final PosDatabase database;
  final ApiClient api;
  final SyncCoordinator sync;
  final Future<void> Function() onRefresh;
  Future<void> createLocalOrder(BuildContext context) async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            Sale(database: database, sync: sync, api: api, asOrder: true),
      ),
    );
    if (saved == true) await onRefresh();
  }

  Future<void> deliver(BuildContext context, CachedOrder order) async {
    final shift = await database.getOpenShift();
    if (!context.mounted) return;
    if (shift == null) {
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Abre el turno antes de entregar pedidos.'),
          ),
        );
      return;
    }
    if (order.source == 'LOCAL') {
      final payment = await showDialog<Map<String, int>>(
        context: context,
        builder: (context) => PaymentDialog(total: order.total),
      );
      if (payment == null) return;
      final eventId = await database.recordLocalDelivery(
        orderId: order.orderId,
        shiftId: shift.shiftId,
        cash: payment['cash']!,
        transfer: payment['transfer']!,
      );
      await sync.syncNow();
      await onRefresh();
      final event = await database.syncEvent(eventId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              event?.syncedAt != null
                  ? 'Pedido local entregado y registrado en Ventas.'
                  : 'Entrega guardada; falta sincronizar: ${event?.lastError ?? 'sin conexión'}',
            ),
          ),
        );
      }
      return;
    }
    final eventId = await database.recordWhatsappDelivery(
      orderId: order.orderId,
      shiftId: shift.shiftId,
    );
    await sync.syncNow();
    final syncEvent = await database.syncEvent(eventId);
    Map<String, dynamic> syncResult = const {};
    try {
      if (syncEvent?.serverResultJson != null) {
        syncResult =
            jsonDecode(syncEvent!.serverResultJson!) as Map<String, dynamic>;
      }
    } catch (_) {}
    await onRefresh();
    final messageError =
        syncResult['message_error']?.toString() ??
        'revisa el token o la ventana de 24 horas.';
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            syncEvent?.syncedAt != null && syncResult['message_sent'] == true
                ? 'Pedido entregado y mensaje enviado por WhatsApp.'
                : syncEvent?.syncedAt != null
                ? 'Pedido entregado, pero WhatsApp no pudo enviar el mensaje: $messageError'
                : syncEvent?.lastError != null
                ? 'Entrega guardada; falta sincronizar: ${syncEvent!.lastError}'
                : 'Entrega guardada. El mensaje se enviará al sincronizar con internet.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'WhatsApp', icon: Icon(Icons.chat_bubble_outline)),
            Tab(text: 'Local', icon: Icon(Icons.storefront_outlined)),
          ],
        ),
        actions: [
          IconButton(onPressed: onRefresh, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: StreamBuilder<List<CachedOrder>>(
        stream: database.watchOrders(),
        builder: (context, snapshot) {
          final rows = snapshot.data ?? const <CachedOrder>[];
          return TabBarView(
            children: [
              _orderList(
                context,
                rows
                    .where(
                      (row) =>
                          row.source == 'WHATSAPP' && row.status != 'ENTREGADO',
                    )
                    .toList(),
              ),
              _orderList(
                context,
                rows
                    .where(
                      (row) =>
                          row.source == 'LOCAL' && row.status != 'ENTREGADO',
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => createLocalOrder(context),
        icon: const Icon(Icons.add),
        label: const Text('Pedido local'),
      ),
    ),
  );
  Widget _orderList(BuildContext context, List<CachedOrder> rows) =>
      RefreshIndicator(
        onRefresh: onRefresh,
        child: rows.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 160),
                  EmptyCard('No hay pedidos en esta ventana.'),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: rows.length,
                itemBuilder: (context, i) {
                  final order = rows[i];
                  return OrderCard(
                    order: order,
                    onFinish: order.status == 'RECIBIDO'
                        ? () => changeStatus(context, order, 'TERMINADO')
                        : null,
                    onCancel: ['RECIBIDO', 'TERMINADO'].contains(order.status)
                        ? () => changeStatus(context, order, 'CANCELADO')
                        : null,
                    onDeliver: order.status == 'TERMINADO'
                        ? () => deliver(context, order)
                        : null,
                  );
                },
              ),
      );
  Future<void> changeStatus(
    BuildContext context,
    CachedOrder order,
    String status,
  ) async {
    final shift = await database.getOpenShift();
    if (!context.mounted) return;
    if (status == 'TERMINADO' && shift == null) {
      if (context.mounted)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Abre el turno antes de terminar pedidos.'),
          ),
        );
      return;
    }
    String reason = '';
    if (status == 'CANCELADO') {
      final controller = TextEditingController();
      reason =
          await showDialog<String>(
            context: context,
            builder: (c) => AlertDialog(
              title: const Text('Motivo de cancelación'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Escribe por qué se cancela',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(c),
                  child: const Text('Volver'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(c, controller.text.trim()),
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ) ??
          '';
      controller.dispose();
      if (reason.isEmpty) return;
    }
    await database.recordOrderStatus(
      orderId: order.orderId,
      status: status,
      reason: reason,
      shiftId: shift?.shiftId,
    );
    await sync.syncNow();
    await onRefresh();
    if (context.mounted)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status == 'TERMINADO' ? 'Pedido listo.' : 'Pedido cancelado.',
          ),
        ),
      );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    this.onFinish,
    this.onCancel,
    this.onDeliver,
  });
  final CachedOrder order;
  final VoidCallback? onFinish, onCancel, onDeliver;
  @override
  Widget build(BuildContext context) {
    final color = order.status == 'RECIBIDO'
        ? Colors.blue
        : order.status == 'CANCELADO'
        ? Colors.red
        : order.status == 'ENTREGADO'
        ? green
        : orange;
    List<dynamic> items;
    try {
      items = jsonDecode(order.productsJson) as List<dynamic>;
    } catch (_) {
      items = const [];
    }
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '${order.source == 'LOCAL' ? 'LOCAL' : 'WHATSAPP'} · ${order.status}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            if (order.phone.isNotEmpty)
              Text(order.phone, style: const TextStyle(color: Colors.black54)),
            if (order.address.isNotEmpty)
              Text(
                'Dirección: ${order.address}',
                style: const TextStyle(color: Colors.black54),
              ),
            const Divider(height: 20),
            ...items
                .take(4)
                .map((item) {
                  if (item is! Map) return const Text('Producto');
                  final modifiers = item['modifiers'];
                  final notes = item['notes']?.toString() ?? '';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item['quantity'] ?? 1} × ${item['name'] ?? 'Producto'}',
                        ),
                        if (modifiers is List && modifiers.isNotEmpty)
                          Text(
                            'Adiciones: ${modifiers.join(', ')}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        if (notes.isNotEmpty)
                          Text(
                            'Indicaciones: $notes',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.paymentMethod),
                Text(
                  cash(order.total),
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            if (onDeliver != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onDeliver,
                    icon: const Icon(Icons.delivery_dining),
                    label: const Text('Marcar entregado · registrar ingreso'),
                  ),
                ),
              ),
            if (onFinish != null || onCancel != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    if (onFinish != null)
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: onFinish,
                          icon: const Icon(Icons.check),
                          label: const Text('Terminado'),
                        ),
                      ),
                    if (onFinish != null && onCancel != null)
                      const SizedBox(width: 8),
                    if (onCancel != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onCancel,
                          icon: const Icon(
                            Icons.cancel_outlined,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Sale extends StatefulWidget {
  const Sale({
    super.key,
    required this.database,
    required this.sync,
    required this.api,
    this.asOrder = false,
  });
  final PosDatabase database;
  final SyncCoordinator sync;
  final ApiClient api;
  final bool asOrder;
  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  final cart = <String, int>{};
  final selectedModifiers = <String, Set<String>>{};
  String? selectedCategory;
  String? localOrderRequestId;
  String? message;
  bool busy = false;
  List<Map<String, dynamic>> modifiers(CachedProduct product) {
    try {
      return (jsonDecode(product.modifiersJson) as List<dynamic>)
          .whereType<Map<String, dynamic>>()
          .toList();
    } catch (_) {
      return const [];
    }
  }

  int unitPrice(CachedProduct product) {
    final selected = selectedModifiers[product.productId] ?? const <String>{};
    return product.price +
        modifiers(product)
            .where((m) => selected.contains(m['id']))
            .fold<int>(0, (sum, m) => sum + (m['price'] as num? ?? 0).round());
  }

  Future<void> chooseModifiers(CachedProduct product) async {
    final options = modifiers(product);
    if (options.isEmpty) return;
    final selected = {...?selectedModifiers[product.productId]};
    final result = await showDialog<Set<String>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, dialogSet) => AlertDialog(
          title: Text('Adiciones · ${product.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((m) {
              final id = m['id'].toString();
              return CheckboxListTile(
                value: selected.contains(id),
                title: Text(m['name'].toString()),
                subtitle: Text(cash(m['price'])),
                onChanged: (v) => dialogSet(
                  () => v == true ? selected.add(id) : selected.remove(id),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, selected),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
    if (result != null)
      setState(() => selectedModifiers[product.productId] = result);
  }

  Future<void> checkout(List<CachedProduct> products) async {
    if (cart.isEmpty) return;
    final shift = widget.asOrder ? null : await widget.database.getOpenShift();
    if (!mounted) return;
    if (!widget.asOrder && shift == null) {
      setState(() => message = 'Abre un turno antes de registrar ventas.');
      return;
    }
    if (widget.asOrder) {
      final details = await showDialog<Map<String, String>>(
        context: context,
        builder: (context) => const LocalOrderDetailsDialog(),
      );
      if (!mounted || details == null) return;
      setState(() => busy = true);
      try {
        await widget.api.createLocalOrder({
          'client_uuid': localOrderRequestId ??= const Uuid().v4(),
          'customer': details['customer'] ?? '',
          'phone': details['phone'] ?? '',
          'address': details['address'] ?? '',
          'modality': details['modality'] ?? 'LOCAL',
          'items': cart.entries
              .map(
                (entry) => <String, Object?>{
                  'product_id': entry.key,
                  'quantity': entry.value,
                  'modifier_ids':
                      (selectedModifiers[entry.key] ?? const <String>{})
                          .toList(),
                },
              )
              .toList(),
        });
        cart.clear();
        selectedModifiers.clear();
        localOrderRequestId = null;
        if (mounted) Navigator.pop(context, true);
      } catch (e) {
        if (mounted) setState(() => message = e.toString());
      } finally {
        if (mounted) setState(() => busy = false);
      }
      return;
    }
    final subtotal = products
        .where((p) => cart.containsKey(p.productId))
        .fold<int>(0, (n, p) => n + unitPrice(p) * cart[p.productId]!);
    final options = await showDialog<Map<String, Object?>>(
      context: context,
      builder: (context) => const SaleOptionsDialog(),
    );
    if (!mounted || options == null) return;
    final total = subtotal + (options['delivery_fee'] as int? ?? 0);
    final payment = await showDialog<Map<String, int>>(
      context: context,
      builder: (context) => PaymentDialog(total: total),
    );
    if (!mounted || payment == null) return;
    setState(() => busy = true);
    try {
      final saleId = await widget.database.recordSale(
        shiftId: shift!.shiftId,
        items: cart.entries
            .map(
              (e) => <String, Object?>{
                'product_id': e.key,
                'quantity': e.value,
                'notes': '',
                'modifier_ids': (selectedModifiers[e.key] ?? const <String>{})
                    .toList(),
              },
            )
            .toList(),
        cash: payment['cash']!,
        transfer: payment['transfer']!,
        deliveryFee: options['delivery_fee'] as int? ?? 0,
        modality: options['modality'] as String? ?? 'LOCAL',
        customer: options['customer'] as String? ?? '',
        address: options['address'] as String? ?? '',
        note: '',
      );
      cart.clear();
      await widget.sync.syncNow();
      final syncEvent = await widget.database.syncEvent(saleId);
      setState(
        () => message = syncEvent?.syncedAt != null
            ? 'Venta guardada y sincronizada con D1.'
            : syncEvent?.lastError != null
            ? 'Venta guardada en el teléfono; D1 respondió: ${syncEvent!.lastError}'
            : 'Venta guardada en el teléfono y pendiente de sincronizar.',
      );
    } catch (e) {
      setState(() => message = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.asOrder ? 'Nuevo pedido local' : 'Venta rápida'),
    ),
    body: StreamBuilder<List<CachedProduct>>(
      stream: widget.database.watchCatalog(),
      builder: (context, s) {
        final products = s.data ?? const <CachedProduct>[];
        final categories =
            products
                .map((product) => product.category.trim())
                .where((category) => category.isNotEmpty)
                .toSet()
                .toList()
              ..sort();
        final visibleProducts = selectedCategory == null
            ? products
            : products.where((p) => p.category == selectedCategory).toList();
        if (selectedCategory != null &&
            !categories.contains(selectedCategory)) {
          selectedCategory = null;
        }
        final total = products
            .where((p) => cart.containsKey(p.productId))
            .fold<int>(0, (n, p) => n + unitPrice(p) * cart[p.productId]!);
        return Column(
          children: [
            if (message != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  message!,
                  style: TextStyle(
                    color: message!.startsWith('Venta guardada')
                        ? green
                        : Colors.red,
                  ),
                ),
              ),
            if (categories.length > 1)
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('Todas'),
                        selected: selectedCategory == null,
                        onSelected: (_) =>
                            setState(() => selectedCategory = null),
                      ),
                    ),
                    ...categories.map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (_) =>
                              setState(() => selectedCategory = category),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: products.isEmpty
                  ? const EmptyCard('Conéctate para descargar el catálogo.')
                  : visibleProducts.isEmpty
                  ? const EmptyCard('No hay productos en esta categoría.')
                  : ListView.builder(
                      itemCount: visibleProducts.length,
                      itemBuilder: (context, i) {
                        final p = visibleProducts[i];
                        final qty = cart[p.productId] ?? 0;
                        return Card(
                          child: ListTile(
                            title: Text(
                              p.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              p.category +
                                  ' · ' +
                                  cash(unitPrice(p)) +
                                  (selectedModifiers[p.productId]?.isNotEmpty ==
                                          true
                                      ? ' · adiciones seleccionadas'
                                      : ''),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (modifiers(p).isNotEmpty)
                                  IconButton(
                                    onPressed: () => chooseModifiers(p),
                                    icon: const Icon(Icons.tune, color: orange),
                                  ),
                                IconButton(
                                  onPressed: qty == 0
                                      ? null
                                      : () => setState(
                                          () => qty == 1
                                              ? cart.remove(p.productId)
                                              : cart[p.productId] = qty - 1,
                                        ),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text(qty.toString()),
                                IconButton(
                                  onPressed: () => setState(
                                    () => cart[p.productId] = qty + 1,
                                  ),
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FilledButton(
                  onPressed: busy || cart.isEmpty
                      ? null
                      : () => checkout(products),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    busy
                        ? 'Guardando…'
                        : widget.asOrder
                        ? 'Guardar pedido · ${cash(total)}'
                        : 'Cobrar · ${cash(total)}',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class LocalOrderDetailsDialog extends StatefulWidget {
  const LocalOrderDetailsDialog({super.key});
  @override
  State<LocalOrderDetailsDialog> createState() =>
      _LocalOrderDetailsDialogState();
}

class _LocalOrderDetailsDialogState extends State<LocalOrderDetailsDialog> {
  final customer = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  String modality = 'LOCAL';
  @override
  void dispose() {
    customer.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Datos del pedido local'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: customer,
            decoration: const InputDecoration(labelText: 'Nombre (opcional)'),
          ),
          TextField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Celular (opcional)'),
          ),
          DropdownButtonFormField<String>(
            value: modality,
            decoration: const InputDecoration(labelText: 'Entrega'),
            items: const [
              DropdownMenuItem(
                value: 'LOCAL',
                child: Text('Recoge en el local'),
              ),
              DropdownMenuItem(value: 'DOMICILIO', child: Text('Domicilio')),
            ],
            onChanged: (value) => setState(() => modality = value ?? 'LOCAL'),
          ),
          TextField(
            controller: address,
            decoration: const InputDecoration(
              labelText: 'Dirección (opcional)',
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Volver'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, {
          'customer': customer.text.trim(),
          'phone': phone.text.trim(),
          'address': address.text.trim(),
          'modality': modality,
        }),
        child: const Text('Guardar pedido'),
      ),
    ],
  );
}

class SaleOptionsDialog extends StatefulWidget {
  const SaleOptionsDialog({super.key});
  @override
  State<SaleOptionsDialog> createState() => _SaleOptionsDialogState();
}

class _SaleOptionsDialogState extends State<SaleOptionsDialog> {
  String modality = 'LOCAL';
  final customer = TextEditingController(),
      address = TextEditingController(),
      fee = TextEditingController(text: '0');
  @override
  void dispose() {
    customer.dispose();
    address.dispose();
    fee.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Entrega del pedido'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            value: modality,
            decoration: const InputDecoration(labelText: 'Modalidad'),
            items: const [
              DropdownMenuItem(value: 'LOCAL', child: Text('Consumo en local')),
              DropdownMenuItem(value: 'LLEVAR', child: Text('Para llevar')),
              DropdownMenuItem(value: 'DOMICILIO', child: Text('Domicilio')),
            ],
            onChanged: (v) => setState(() => modality = v ?? 'LOCAL'),
          ),
          TextField(
            controller: customer,
            decoration: const InputDecoration(labelText: 'Nombre (opcional)'),
          ),
          if (modality == 'DOMICILIO') ...[
            TextField(
              controller: address,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: fee,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tarifa de domicilio',
              ),
            ),
          ],
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Volver'),
      ),
      FilledButton(
        onPressed: () {
          final amount = int.tryParse(fee.text) ?? 0;
          if (modality == 'DOMICILIO' && address.text.trim().isEmpty) return;
          Navigator.pop(context, <String, Object?>{
            'modality': modality,
            'customer': customer.text.trim(),
            'address': address.text.trim(),
            'delivery_fee': modality == 'DOMICILIO' ? amount : 0,
          });
        },
        child: const Text('Continuar'),
      ),
    ],
  );
}

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({super.key, required this.total});
  final int total;
  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  String method = 'Efectivo';
  final cashController = TextEditingController();
  @override
  void dispose() {
    cashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cashPart = method == 'Efectivo'
        ? widget.total
        : method == 'Transferencia'
        ? 0
        : int.tryParse(cashController.text) ?? 0;
    final transferPart = widget.total - cashPart;
    return AlertDialog(
      title: const Text('Confirmar cobro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            cash(widget.total),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          RadioListTile<String>(
            title: const Text('Efectivo'),
            value: 'Efectivo',
            groupValue: method,
            onChanged: (v) => setState(() => method = v!),
          ),
          RadioListTile<String>(
            title: const Text('Transferencia'),
            value: 'Transferencia',
            groupValue: method,
            onChanged: (v) => setState(() => method = v!),
          ),
          RadioListTile<String>(
            title: const Text('Pago mixto'),
            value: 'Mixto',
            groupValue: method,
            onChanged: (v) => setState(() => method = v!),
          ),
          if (method == 'Mixto')
            TextField(
              controller: cashController,
              onChanged: (_) => setState(() {}),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Parte en efectivo · restante transferencia',
                helperText: 'Transferencia: ${cash(transferPart)}',
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Volver'),
        ),
        FilledButton(
          onPressed: cashPart < 0 || cashPart > widget.total
              ? null
              : () => Navigator.pop(context, <String, int>{
                  'cash': cashPart,
                  'transfer': transferPart,
                }),
          child: const Text('Guardar venta'),
        ),
      ],
    );
  }
}

class Cash extends StatefulWidget {
  const Cash({
    super.key,
    required this.database,
    required this.api,
    required this.sync,
  });
  final PosDatabase database;
  final ApiClient api;
  final SyncCoordinator sync;
  @override
  State<Cash> createState() => _CashState();
}

class _CashState extends State<Cash> {
  String? message;
  Future<int?> amount(String title) async {
    final c = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: c,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText: '\$ ',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, int.tryParse(c.text)),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Future<void> open() async {
    final opening = await amount('Base inicial en efectivo');
    if (opening == null) return;
    final user = await widget.api.userId ?? 'env-admin';
    final shift = const Uuid().v4();
    await widget.database.saveShift(
      id: shift,
      userId: user,
      openingCash: opening,
      openedAt: DateTime.now().toUtc(),
    );
    await widget.database.enqueue('shift_open', {
      'shift_id': shift,
      'opening_cash': opening,
    });
    await widget.sync.syncNow();
    if (mounted)
      setState(() => message = 'Turno abierto con base de ' + cash(opening));
  }

  Future<void> expense(LocalShift shift) async {
    final value = await amount('Valor del gasto');
    if (value == null || !mounted) return;
    final note = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Motivo del gasto'),
        content: TextField(
          controller: note,
          decoration: const InputDecoration(hintText: 'Ej. compra de hielo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, note.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (reason == null || reason.trim().isEmpty) return;
    await widget.database.enqueue('cash_movement', {
      'shift_id': shift.shiftId,
      'movement_type': 'GASTO',
      'amount': value,
      'note': reason.trim(),
    });
    await widget.sync.syncNow();
    if (mounted) setState(() => message = 'Gasto registrado.');
  }

  Future<void> addBase(LocalShift shift) async {
    final value = await amount('Aporte adicional de base');
    if (value == null || value < 1) return;
    final note = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Motivo del aporte'),
        content: TextField(
          controller: note,
          decoration: const InputDecoration(
            hintText: 'Ej. cambio inicial adicional',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Volver'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, note.text.trim()),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (reason == null || reason.isEmpty) return;
    await widget.database.enqueue('cash_movement', {
      'shift_id': shift.shiftId,
      'movement_type': 'APORTE_BASE',
      'amount': value,
      'note': reason,
    });
    await widget.sync.syncNow();
    if (mounted) setState(() => message = 'Aporte de base registrado.');
  }

  Future<void> closeShift(LocalShift shift) async {
    final countedCash = await amount('Efectivo contado');
    if (countedCash == null) return;
    final transfer = await amount('Transferencias contadas');
    if (transfer == null) return;
    await widget.database.enqueue('shift_close', {
      'shift_id': shift.shiftId,
      'counted_cash': countedCash,
      'counted_transfer': transfer,
    });
    await widget.database.closeShiftLocal(shift.shiftId);
    await widget.sync.syncNow();
    final result = await widget.database.latestCloseResult();
    if (mounted)
      setState(
        () => message = result == null
            ? 'Cierre guardado. Se calculará cuando el teléfono se conecte.'
            : 'Cierre sincronizado · efectivo esperado ${cash(result['expected_cash'])} (${cash(result['difference_cash'])}) · transferencias esperadas ${cash(result['expected_transfer'])} (${cash(result['difference_transfer'])}).',
      );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Caja y turnos')),
    body: FutureBuilder<LocalShift?>(
      future: widget.database.getOpenShift(),
      builder: (context, s) {
        final shift = s.data;
        return ListView(
          padding: const EdgeInsets.all(14),
          children: [
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(message!, style: const TextStyle(color: green)),
              ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shift == null ? 'Caja cerrada' : 'Turno abierto',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (shift != null)
                      Text('Base inicial: ' + cash(shift.openingCash)),
                    const SizedBox(height: 12),
                    if (shift == null)
                      FilledButton.icon(
                        onPressed: open,
                        icon: const Icon(Icons.lock_open),
                        label: const Text('Abrir turno'),
                      )
                    else ...[
                      OutlinedButton.icon(
                        onPressed: () => expense(shift),
                        icon: const Icon(Icons.remove_circle_outline),
                        label: const Text('Registrar gasto'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => addBase(shift),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Aportar a la base'),
                      ),
                      FilledButton.icon(
                        onPressed: () => closeShift(shift),
                        icon: const Icon(Icons.lock),
                        label: const Text('Cerrar turno · conteo ciego'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: widget.database.watchPendingCount(),
              builder: (context, p) => Card(
                child: ListTile(
                  leading: const Icon(Icons.sync, color: orange),
                  title: Text(
                    (p.data ?? 0).toString() + ' pendientes de sincronizar',
                  ),
                  subtitle: const Text(
                    'El saldo esperado no se muestra antes de hacer el conteo.',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class More extends StatelessWidget {
  const More({
    super.key,
    required this.database,
    required this.api,
    required this.sync,
    required this.role,
    required this.onRefresh,
    required this.onLogout,
  });
  final PosDatabase database;
  final ApiClient api;
  final SyncCoordinator sync;
  final String role;
  final Future<void> Function() onRefresh;
  final VoidCallback onLogout;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Más')),
    body: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.verified_user, color: green),
            title: Text(role),
            subtitle: const Text('Permisos del usuario activo'),
          ),
        ),
        ListTileCard(
          title: 'Inventario',
          subtitle: 'Existencias, compras, mermas y ajustes',
          icon: Icons.inventory_2,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  Inventory(database: database, role: role, sync: sync),
            ),
          ),
        ),
        if (role == 'ADMIN')
          ListTileCard(
            title: 'Administración',
            subtitle: 'Productos, insumos, recetas y cajeros',
            icon: Icons.settings,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminPage(
                  database: database,
                  api: api,
                  onRefresh: onRefresh,
                ),
              ),
            ),
          ),
        if (role == 'ADMIN')
          ListTileCard(
            title: 'Auditoría',
            subtitle: 'Cambios sensibles y motivos',
            icon: Icons.fact_check,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Audit(api: api)),
            ),
          ),
        if (role == 'ADMIN')
          ListTileCard(
            title: 'Reportes',
            subtitle: 'Ingresos, costos, utilidad y horas pico',
            icon: Icons.analytics,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    Reports(api: api, database: database, sync: sync),
              ),
            ),
          ),
        ListTileCard(
          title: 'Actualizar datos',
          subtitle: 'Catálogo, pedidos e inventario',
          icon: Icons.refresh,
          onTap: onRefresh,
        ),
        OutlinedButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout),
          label: const Text('Cerrar sesión'),
        ),
      ],
    ),
  );
}

class Inventory extends StatefulWidget {
  const Inventory({
    super.key,
    required this.database,
    required this.role,
    required this.sync,
  });
  final PosDatabase database;
  final String role;
  final SyncCoordinator sync;
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Future<void> movement(CachedIngredient ingredient, String type) async {
    final q = TextEditingController();
    final cost = TextEditingController();
    final reason = TextEditingController();
    final values = await showDialog<List<String>>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          type == 'inventory_purchase'
              ? 'Registrar compra'
              : type == 'inventory_loss'
              ? 'Registrar merma'
              : 'Ajustar conteo físico',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ingredient.name +
                  ' · actual ' +
                  ingredient.quantity.toString() +
                  ' ' +
                  ingredient.unit,
            ),
            TextField(
              controller: q,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: type == 'inventory_adjustment'
                    ? 'Diferencia (+/-)'
                    : 'Cantidad',
              ),
            ),
            if (type == 'inventory_purchase')
              TextField(
                controller: cost,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Costo total de compra',
                ),
              ),
            TextField(
              controller: reason,
              decoration: const InputDecoration(
                labelText: 'Motivo obligatorio',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Volver'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, [q.text, cost.text, reason.text]),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (values == null) return;
    final quantity = double.tryParse(values[0]);
    final note = values[2].trim();
    if (quantity == null || quantity == 0 || note.isEmpty) return;
    await widget.database.recordInventoryMovement(type, {
      'ingredient_id': ingredient.ingredientId,
      'quantity': quantity,
      'total_cost': double.tryParse(values[1]) ?? 0,
      'reason': note,
      'loss_type': 'MERMA',
    });
    await widget.sync.syncNow();
    if (mounted)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Movimiento guardado.')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Insumos')),
    body: StreamBuilder<List<CachedIngredient>>(
      stream: widget.database.watchIngredients(),
      builder: (context, s) {
        final items = s.data ?? const <CachedIngredient>[];
        if (items.isEmpty)
          return const EmptyCard('El administrador agregará los insumos.');
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          itemBuilder: (context, i) {
            final item = items[i];
            final low = item.quantity <= item.minimum;
            return Card(
              child: ListTile(
                leading: Icon(
                  low ? Icons.warning : Icons.inventory_2,
                  color: low ? Colors.red : green,
                ),
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Mínimo ' + item.minimum.toString() + ' ' + item.unit,
                ),
                trailing: widget.role == 'ADMIN'
                    ? PopupMenuButton<String>(
                        onSelected: (v) => movement(item, v),
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'inventory_purchase',
                            child: Text('Registrar compra'),
                          ),
                          PopupMenuItem(
                            value: 'inventory_loss',
                            child: Text('Registrar merma'),
                          ),
                          PopupMenuItem(
                            value: 'inventory_adjustment',
                            child: Text('Ajustar conteo'),
                          ),
                        ],
                      )
                    : Text(
                        item.quantity.toString() + ' ' + item.unit,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: low ? Colors.red : green,
                        ),
                      ),
              ),
            );
          },
        );
      },
    ),
  );
}

class AdminPage extends StatelessWidget {
  const AdminPage({
    super.key,
    required this.database,
    required this.api,
    required this.onRefresh,
  });
  final PosDatabase database;
  final ApiClient api;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Administración')),
    body: ListView(
      padding: const EdgeInsets.all(14),
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Solo ADMIN administra usuarios, productos, precios, costos y recetas. Los cambios requieren motivo y quedan auditados.',
            ),
          ),
        ),
        ListTileCard(
          title: 'Crear producto',
          subtitle: 'Nombre, categoría y precio',
          icon: Icons.add_box,
          onTap: () => productDialog(context, api, onRefresh),
        ),
        ListTileCard(
          title: 'Editar o activar productos',
          subtitle: 'Cambiar precio y disponibilidad',
          icon: Icons.edit_note,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductManagement(api: api, onRefresh: onRefresh),
            ),
          ),
        ),
        ListTileCard(
          title: 'Crear insumo',
          subtitle: 'Unidad, existencia, mínimo y costo',
          icon: Icons.inventory_2,
          onTap: () => ingredientDialog(context, api, onRefresh),
        ),
        ListTileCard(
          title: 'Asignar receta a producto',
          subtitle: 'Fijar insumos y cantidades por producto',
          icon: Icons.restaurant_menu,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RecipePage(database: database, api: api),
            ),
          ),
        ),
        ListTileCard(
          title: 'Crear modificador o adición',
          subtitle: 'Configurar precio extra y productos disponibles',
          icon: Icons.add_circle_outline,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ModifierPage(database: database, api: api),
            ),
          ),
        ),
        ListTileCard(
          title: 'Crear cajero',
          subtitle: 'Usuario y PIN de 4 a 8 dígitos',
          icon: Icons.person_add,
          onTap: () => userDialog(context, api),
        ),
      ],
    ),
  );
}

class ProductManagement extends StatefulWidget {
  const ProductManagement({
    super.key,
    required this.api,
    required this.onRefresh,
  });
  final ApiClient api;
  final Future<void> Function() onRefresh;
  @override
  State<ProductManagement> createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late Future<List<Map<String, dynamic>>> products = widget.api.adminProducts();
  void reload() => setState(() => products = widget.api.adminProducts());

  Future<void> pause(Map<String, dynamic> product) async {
    final reason = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(
          (product['active'] == 1 || product['active'] == true)
              ? 'Desactivar producto'
              : 'Activar producto',
        ),
        content: TextField(
          controller: reason,
          decoration: const InputDecoration(labelText: 'Motivo obligatorio'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Volver'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, reason.text.trim()),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
    reason.dispose();
    if (note == null || note.isEmpty) return;
    try {
      await widget.api.createProduct({
        'id': product['id'],
        'name': product['name'],
        'category': product['category'],
        'description': product['description'],
        'price': product['price'],
        'active': !(product['active'] == 1 || product['active'] == true),
        'reason': note,
      });
      reload();
      await widget.onRefresh();
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> edit(Map<String, dynamic> product) async {
    final name = TextEditingController(text: product['name'].toString());
    final category = TextEditingController(
      text: product['category'].toString(),
    );
    final description = TextEditingController(
      text: product['description'].toString(),
    );
    final price = TextEditingController(text: product['price'].toString());
    final reason = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Editar producto'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: category,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              TextField(
                controller: description,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
              ),
              TextField(
                controller: reason,
                decoration: const InputDecoration(
                  labelText: 'Motivo del cambio',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await widget.api.createProduct({
                  'id': product['id'],
                  'name': name.text.trim(),
                  'category': category.text.trim(),
                  'description': description.text.trim(),
                  'price': int.tryParse(price.text),
                  'active': product['active'] == true || product['active'] == 1,
                  'reason': reason.text.trim(),
                });
                if (c.mounted) Navigator.pop(c);
                reload();
                await widget.onRefresh();
              } catch (e) {
                if (c.mounted)
                  ScaffoldMessenger.of(
                    c,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    name.dispose();
    category.dispose();
    description.dispose();
    price.dispose();
    reason.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Productos')),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: products,
      builder: (context, s) {
        if (s.connectionState != ConnectionState.done)
          return const Center(child: CircularProgressIndicator());
        if (s.hasError) return EmptyCard(s.error.toString());
        final rows = s.data ?? const <Map<String, dynamic>>[];
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: rows.length,
          itemBuilder: (context, i) {
            final product = rows[i];
            final active = product['active'] == 1 || product['active'] == true;
            return Card(
              child: ListTile(
                title: Text(product['name'].toString()),
                subtitle: Text(
                  '${product['category']} · ${cash(product['price'])} · ${active ? 'Activo' : 'Inactivo'}',
                ),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) =>
                      value == 'edit' ? edit(product) : pause(product),
                  itemBuilder: (_) => const [
                    PopupMenuItem(value: 'edit', child: Text('Editar')),
                    PopupMenuItem(
                      value: 'pause',
                      child: Text('Activar / desactivar'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

class ModifierPage extends StatefulWidget {
  const ModifierPage({super.key, required this.database, required this.api});
  final PosDatabase database;
  final ApiClient api;
  @override
  State<ModifierPage> createState() => _ModifierPageState();
}

class _ModifierPageState extends State<ModifierPage> {
  final name = TextEditingController(),
      price = TextEditingController(text: '0');
  final selected = <String>{};
  String? message;
  bool busy = false;
  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Modificadores')),
    body: StreamBuilder<List<CachedProduct>>(
      stream: widget.database.watchCatalog(),
      builder: (context, s) {
        final products = s.data ?? const <CachedProduct>[];
        return ListView(
          padding: const EdgeInsets.all(14),
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Nombre · extra queso, sin cebolla',
              ),
            ),
            TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio extra (puede ser 0)',
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Disponible para',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...products.map(
              (p) => CheckboxListTile(
                value: selected.contains(p.productId),
                title: Text(p.name),
                onChanged: (v) => setState(
                  () => v == true
                      ? selected.add(p.productId)
                      : selected.remove(p.productId),
                ),
              ),
            ),
            if (message != null) Text(message!),
            FilledButton(
              onPressed: busy
                  ? null
                  : () async {
                      if (name.text.trim().isEmpty || selected.isEmpty) {
                        setState(
                          () => message =
                              'Escribe el nombre y selecciona al menos un producto.',
                        );
                        return;
                      }
                      setState(() => busy = true);
                      try {
                        await widget.api.saveModifier({
                          'name': name.text.trim(),
                          'price_extra': int.tryParse(price.text) ?? 0,
                          'product_ids': selected.toList(),
                          'ingredients': [],
                          'reason': 'Creación inicial',
                        });
                        if (mounted)
                          setState(() => message = 'Modificador guardado.');
                      } catch (e) {
                        if (mounted) setState(() => message = e.toString());
                      } finally {
                        if (mounted) setState(() => busy = false);
                      }
                    },
              child: Text(busy ? 'Guardando…' : 'Guardar modificador'),
            ),
          ],
        );
      },
    ),
  );
}

Future<void> ingredientDialog(
  BuildContext context,
  ApiClient api,
  Future<void> Function() refresh,
) async {
  final name = TextEditingController(),
      quantity = TextEditingController(text: '0'),
      minimum = TextEditingController(text: '0'),
      cost = TextEditingController(text: '0'),
      reason = TextEditingController(text: 'Existencia inicial');
  String unit = 'UNIDAD';
  await showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialog) => AlertDialog(
        title: const Text('Nuevo insumo'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              DropdownButtonFormField<String>(
                value: unit,
                decoration: const InputDecoration(labelText: 'Unidad'),
                items: const ['UNIDAD', 'G', 'KG', 'ML', 'L']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setDialog(() => unit = v ?? 'UNIDAD'),
              ),
              TextField(
                controller: quantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Existencia inicial',
                ),
              ),
              TextField(
                controller: minimum,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stock mínimo'),
              ),
              TextField(
                controller: cost,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Costo por unidad de medida',
                ),
              ),
              TextField(
                controller: reason,
                decoration: const InputDecoration(labelText: 'Motivo'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              try {
                await api.createIngredient({
                  'name': name.text,
                  'unit': unit,
                  'quantity': double.tryParse(quantity.text),
                  'minimum': double.tryParse(minimum.text),
                  'unit_cost': double.tryParse(cost.text),
                  'reason': reason.text,
                });
                await refresh();
                if (context.mounted) Navigator.pop(context);
              } catch (e) {
                if (context.mounted)
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    ),
  );
  name.dispose();
  quantity.dispose();
  minimum.dispose();
  cost.dispose();
  reason.dispose();
}

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.database, required this.api});
  final PosDatabase database;
  final ApiClient api;
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String? productId;
  final Map<String, TextEditingController> amounts = {};
  final reason = TextEditingController();
  String? message;
  bool busy = false;
  @override
  void dispose() {
    for (final c in amounts.values) {
      c.dispose();
    }
    reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Receta del producto')),
    body: StreamBuilder<List<CachedProduct>>(
      stream: widget.database.watchCatalog(),
      builder: (context, p) {
        final products = p.data ?? const <CachedProduct>[];
        return StreamBuilder<List<CachedIngredient>>(
          stream: widget.database.watchIngredients(),
          builder: (context, i) {
            final ingredients = i.data ?? const <CachedIngredient>[];
            if (products.isEmpty || ingredients.isEmpty)
              return const EmptyCard(
                'Primero crea productos e insumos para asignar recetas.',
              );
            productId ??= products.first.productId;
            return ListView(
              padding: const EdgeInsets.all(14),
              children: [
                DropdownButtonFormField<String>(
                  value: productId,
                  decoration: const InputDecoration(
                    labelText: 'Producto',
                    border: OutlineInputBorder(),
                  ),
                  items: products
                      .map(
                        (v) => DropdownMenuItem(
                          value: v.productId,
                          child: Text(v.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => productId = v),
                ),
                const SizedBox(height: 14),
                Text(
                  'Cantidad de cada insumo por unidad de producto',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ...ingredients.map((item) {
                  amounts.putIfAbsent(
                    item.ingredientId,
                    TextEditingController.new,
                  );
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: amounts[item.ingredientId],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: item.name + ' (' + item.unit + ')',
                          hintText: 'Cantidad consumida',
                        ),
                      ),
                    ),
                  );
                }),
                TextField(
                  controller: reason,
                  decoration: const InputDecoration(
                    labelText: 'Motivo de la receta',
                  ),
                ),
                if (message != null)
                  Text(message!, style: const TextStyle(color: green)),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: busy
                      ? null
                      : () async {
                          final rows = amounts.entries
                              .where(
                                (e) =>
                                    double.tryParse(e.value.text.trim()) !=
                                        null &&
                                    double.parse(e.value.text.trim()) > 0,
                              )
                              .map(
                                (e) => {
                                  'ingredient_id': e.key,
                                  'quantity': double.parse(e.value.text.trim()),
                                },
                              )
                              .toList();
                          if (rows.isEmpty) {
                            setState(
                              () => message = 'Agrega por lo menos un insumo.',
                            );
                            return;
                          }
                          setState(() => busy = true);
                          try {
                            await widget.api.saveRecipe({
                              'product_id': productId,
                              'ingredients': rows,
                              'reason': reason.text,
                            });
                            if (mounted)
                              setState(() => message = 'Receta guardada.');
                          } catch (e) {
                            if (mounted) setState(() => message = e.toString());
                          } finally {
                            if (mounted) setState(() => busy = false);
                          }
                        },
                  child: Text(busy ? 'Guardando…' : 'Guardar receta'),
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

Future<void> productDialog(
  BuildContext context,
  ApiClient api,
  Future<void> Function() refresh,
) async {
  final n = TextEditingController(),
      c = TextEditingController(),
      p = TextEditingController();
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nuevo producto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: n,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: c,
            decoration: const InputDecoration(labelText: 'Categoría'),
          ),
          TextField(
            controller: p,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Precio'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            try {
              await api.createProduct({
                'name': n.text,
                'category': c.text,
                'price': int.tryParse(p.text),
                'reason': 'Alta de producto',
              });
              await refresh();
              if (context.mounted) Navigator.pop(context);
            } catch (e) {
              if (context.mounted)
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
  n.dispose();
  c.dispose();
  p.dispose();
}

Future<void> userDialog(BuildContext context, ApiClient api) async {
  final n = TextEditingController(), pin = TextEditingController();
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Crear cajero'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: n,
            decoration: const InputDecoration(labelText: 'Usuario'),
          ),
          TextField(
            controller: pin,
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'PIN (4-8 números)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            try {
              await api.createUser({
                'name': n.text,
                'pin': pin.text,
                'role': 'CAJERO',
              });
              if (context.mounted) Navigator.pop(context);
            } catch (e) {
              if (context.mounted)
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          child: const Text('Crear'),
        ),
      ],
    ),
  );
  n.dispose();
  pin.dispose();
}

class Reports extends StatefulWidget {
  const Reports({
    super.key,
    required this.api,
    required this.database,
    required this.sync,
  });
  final ApiClient api;
  final PosDatabase database;
  final SyncCoordinator sync;
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  late DateTime start = DateTime.now().subtract(const Duration(days: 6));
  late DateTime end = DateTime.now();
  String day(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
  Future<void> chooseRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      initialDateRange: DateTimeRange(start: start, end: end),
    );
    if (range != null)
      setState(() {
        start = range.start;
        end = range.end;
      });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Ventas'),
      actions: [
        IconButton(
          tooltip: 'Venta rápida',
          onPressed: () async {
            await Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => Sale(
                  database: widget.database,
                  sync: widget.sync,
                  api: widget.api,
                ),
              ),
            );
            if (mounted) setState(() {});
          },
          icon: const Icon(Icons.add_shopping_cart),
        ),
        IconButton(
          onPressed: chooseRange,
          tooltip: 'Filtrar fechas',
          icon: const Icon(Icons.date_range),
        ),
      ],
    ),
    body: FutureBuilder<Map<String, dynamic>>(
      future: widget.api.reports(start: day(start), end: day(end)),
      builder: (context, s) {
        if (s.connectionState != ConnectionState.done)
          return const Center(child: CircularProgressIndicator());
        if (s.hasError) return EmptyCard(s.error.toString());
        final data = s.data ?? const {};
        final summary = data['summary'] as Map<String, dynamic>? ?? const {};
        final products = data['products'] as List<dynamic>? ?? const [];
        final deliveredProducts =
            data['delivered_products'] as List<dynamic>? ?? const [];
        final hours = data['peak_hours'] as List<dynamic>? ?? const [];
        final closures = data['closures'] as Map<String, dynamic>? ?? const {};
        return ListView(
          padding: const EdgeInsets.all(14),
          children: [
            Text(
              '${day(start)} a ${day(end)}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: green),
                title: const Text('Ventas entregadas'),
                subtitle: const Text(
                  'Historial permanente · WhatsApp y local',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeliveredSales(api: widget.api),
                  ),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.45,
              children: [
                Metric(
                  title: 'Ingresos',
                  value: cash(summary['ingresos']),
                  icon: Icons.payments,
                  color: green,
                ),
                Metric(
                  title: 'Costo de venta',
                  value: cash(summary['costo']),
                  icon: Icons.inventory,
                  color: orange,
                ),
                Metric(
                  title: 'Gastos',
                  value: cash(summary['gastos']),
                  icon: Icons.money_off,
                  color: Colors.red,
                ),
                Metric(
                  title: 'Utilidad neta',
                  value: cash(summary['utilidad_neta']),
                  icon: Icons.trending_up,
                  color: green,
                ),
              ],
            ),
            Card(
              child: ListTile(
                title: const Text('Efectivo'),
                trailing: Text(cash(summary['efectivo'])),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Transferencias'),
                trailing: Text(cash(summary['transferencia'])),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Ticket promedio'),
                subtitle: Text('${summary['tickets'] ?? 0} transacciones'),
                trailing: Text(cash(summary['ticket_promedio'])),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Productos en pedidos entregados',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            if (deliveredProducts.isEmpty)
              const EmptyCard(
                'No hay productos de pedidos entregados en este período.',
              )
            else
              ...deliveredProducts.map((value) {
                final row = value as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.delivery_dining,
                      color: green,
                    ),
                    title: Text(row['producto']?.toString() ?? 'Producto'),
                    subtitle: Text(
                      '${row['unidades'] ?? 0} unidades · ${row['pedidos'] ?? 0} pedidos entregados',
                    ),
                    trailing: Text(cash(row['ventas'])),
                  ),
                );
              }),
            const SizedBox(height: 10),
            Text(
              'Productos más vendidos',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            ...products.map((v) {
              final row = v as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text(row['producto'].toString()),
                  subtitle: Text(
                    '${row['unidades']} unidades · margen bruto ${cash((num.tryParse(row['ventas'].toString()) ?? 0) - (num.tryParse(row['costo'].toString()) ?? 0))}',
                  ),
                  trailing: Text(cash(row['ventas'])),
                ),
              );
            }),
            const SizedBox(height: 8),
            Text(
              'Horas de mayor movimiento',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            ...hours.map((v) {
              final row = v as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.schedule, color: orange),
                  title: Text('${row['hora']}:00'),
                  trailing: Text('${row['ventas']} ventas'),
                ),
              );
            }),
            Card(
              child: ListTile(
                leading: const Icon(Icons.fact_check, color: green),
                title: Text('${closures['cierres'] ?? 0} cierres de caja'),
                subtitle: Text(
                  '${closures['faltantes'] ?? 0} faltantes · ${closures['sobrantes'] ?? 0} sobrantes',
                ),
                trailing: Text('Dif. ${cash(closures['diferencia_efectivo'])}'),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class DeliveredSales extends StatefulWidget {
  const DeliveredSales({super.key, required this.api});
  final ApiClient api;

  @override
  State<DeliveredSales> createState() => _DeliveredSalesState();
}

class _DeliveredSalesState extends State<DeliveredSales> {
  late Future<List<Map<String, dynamic>>> sales = widget.api.salesHistory();

  void reload() => setState(() => sales = widget.api.salesHistory());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Ventas entregadas'),
      actions: [
        IconButton(
          onPressed: reload,
          tooltip: 'Actualizar historial',
          icon: const Icon(Icons.refresh),
        ),
      ],
    ),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: sales,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) return EmptyCard(snapshot.error.toString());
        final rows = snapshot.data ?? const <Map<String, dynamic>>[];
        if (rows.isEmpty) {
          return const EmptyCard('Todavía no hay ventas entregadas guardadas.');
        }
        return RefreshIndicator(
          onRefresh: () async => reload(),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: rows.length,
            itemBuilder: (context, index) => DeliveredSaleCard(sale: rows[index]),
          ),
        );
      },
    ),
  );
}

class DeliveredSaleCard extends StatelessWidget {
  const DeliveredSaleCard({super.key, required this.sale});
  final Map<String, dynamic> sale;

  @override
  Widget build(BuildContext context) {
    final isQuickSale = sale['type'] == 'VENTA';
    final isWhatsApp = sale['source'] == 'WHATSAPP';
    final sourceLabel = isQuickSale
        ? 'Venta local'
        : isWhatsApp
        ? 'WhatsApp'
        : 'Pedido local';
    final modality = switch (sale['modality']?.toString()) {
      'DOMICILIO' => 'Domicilio',
      'LLEVAR' => 'Para llevar',
      _ => 'Recoger en el local',
    };
    final reference = sale['order_id']?.toString() ??
        sale['reference']?.toString().substring(0, 8) ?? '';
    final items = sale['products'] as List<dynamic>? ?? const [];
    final address = sale['address']?.toString() ?? '';
    final phone = sale['phone']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sale['customer_name']?.toString().isNotEmpty == true
                        ? sale['customer_name'].toString()
                        : 'Cliente local',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F3ED),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    sourceLabel,
                    style: const TextStyle(
                      color: green,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              '${reference.isEmpty ? '' : '#$reference · '}${sale['sold_at'] ?? ''}',
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            if (phone.isNotEmpty) Text('Celular: $phone'),
            const Divider(height: 22),
            ...items.map((value) {
              if (value is! Map) return const SizedBox.shrink();
              final item = Map<String, dynamic>.from(value);
              final quantity = int.tryParse(item['quantity'].toString()) ?? 1;
              final unitPrice = item['price'] ?? 0;
              final modifiers = item['modifiers'];
              final notes = item['notes']?.toString() ?? '';
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$quantity × ${item['name'] ?? 'Producto'}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(cash((num.tryParse(unitPrice.toString()) ?? 0) * quantity)),
                      ],
                    ),
                    if (modifiers is List && modifiers.isNotEmpty)
                      Text(
                        'Adiciones: ${modifiers.join(', ')}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    if (notes.isNotEmpty)
                      Text(
                        'Nota: $notes',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              );
            }),
            const Divider(height: 18),
            _saleDetail('Pago', sale['payment_method']?.toString() ?? ''),
            _saleDetail('Efectivo', cash(sale['cash'])),
            _saleDetail('Transferencia', cash(sale['transfer'])),
            _saleDetail('Entrega', modality),
            if (address.isNotEmpty) _saleDetail('Dirección', address),
            if ((num.tryParse(sale['delivery_fee'].toString()) ?? 0) > 0)
              _saleDetail('Domicilio', cash(sale['delivery_fee'])),
            const Divider(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(
                  cash(sale['total']),
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _saleDetail(String title, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 92,
          child: Text(title, style: const TextStyle(color: Colors.black54)),
        ),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

class Audit extends StatelessWidget {
  const Audit({super.key, required this.api});
  final ApiClient api;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Auditoría')),
    body: FutureBuilder<Map<String, dynamic>>(
      future: api.audit(),
      builder: (context, s) {
        if (s.connectionState != ConnectionState.done)
          return const Center(child: CircularProgressIndicator());
        final rows = s.data?['records'] as List<dynamic>? ?? const [];
        if (rows.isEmpty)
          return const EmptyCard('Sin acciones registradas todavía.');
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: rows.length,
          itemBuilder: (context, i) {
            final r = rows[i] as Map<String, dynamic>;
            return Card(
              child: ListTile(
                title: Text(r['accion'].toString()),
                subtitle: Text(
                  r['usuario'].toString() + ' · ' + r['motivo'].toString(),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(icon, color: green),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}

class EmptyCard extends StatelessWidget {
  const EmptyCard(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_outlined, size: 40, color: orange),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    ),
  );
}

String cash(Object? value) {
  final number = value is num
      ? value.round()
      : int.tryParse(value?.toString() ?? '') ?? 0;
  final raw = number.abs().toString();
  final out = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    out.write(raw[i]);
    final left = raw.length - i - 1;
    if (left > 0 && left % 3 == 0) out.write('.');
  }
  return '\$' + (number < 0 ? '-' : '') + out.toString();
}
