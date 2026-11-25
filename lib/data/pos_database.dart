import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:uuid/uuid.dart';

part 'pos_database.g.dart';

class CachedProducts extends Table {
  TextColumn get productId => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  IntColumn get price => integer()();
  TextColumn get modifiersJson => text().withDefault(const Constant('[]'))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  @override
  Set<Column<Object>> get primaryKey => {productId};
}

class CachedIngredients extends Table {
  TextColumn get ingredientId => text()();
  TextColumn get name => text()();
  TextColumn get unit => text()();
  RealColumn get quantity => real().withDefault(const Constant(0))();
  RealColumn get minimum => real().withDefault(const Constant(0))();
  RealColumn get unitCost => real().withDefault(const Constant(0))();
  @override
  Set<Column<Object>> get primaryKey => {ingredientId};
}

class ProductRecipes extends Table {
  TextColumn get productId => text()();
  TextColumn get ingredientId => text()();
  RealColumn get quantity => real()();
  RealColumn get unitCost => real()();
  @override
  Set<Column<Object>> get primaryKey => {productId, ingredientId};
}

class LocalShifts extends Table {
  TextColumn get shiftId => text()();
  TextColumn get userId => text()();
  IntColumn get openingCash => integer()();
  DateTimeColumn get openedAt => dateTime()();
  TextColumn get state => text().withDefault(const Constant('ABIERTO'))();
  @override
  Set<Column<Object>> get primaryKey => {shiftId};
}

class SyncOutbox extends Table {
  TextColumn get clientUuid => text()();
  TextColumn get eventType => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
  TextColumn get lastError => text().nullable()();
  TextColumn get serverResultJson => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {clientUuid};
}

class LocalSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override
  Set<Column<Object>> get primaryKey => {key};
}

class CachedOrders extends Table {
  IntColumn get orderId => integer()();
  TextColumn get customerName => text()();
  TextColumn get phone => text()();
  TextColumn get status => text()();
  TextColumn get productsJson => text()();
  IntColumn get total => integer()();
  TextColumn get paymentMethod => text()();
  TextColumn get source => text().withDefault(const Constant('WHATSAPP'))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get recipeSnapshotJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get ingredientsConsumed =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {orderId};
}

class CachedSales extends Table {
  TextColumn get sourceId => text()();
  TextColumn get customerName => text()();
  TextColumn get phone => text().withDefault(const Constant(''))();
  TextColumn get status => text().withDefault(const Constant('ENTREGADO'))();
  TextColumn get productsJson => text()();
  IntColumn get total => integer()();
  TextColumn get paymentMethod => text()();
  TextColumn get modality => text().withDefault(const Constant('LOCAL'))();
  TextColumn get address => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {sourceId};
}

@DriftDatabase(
  tables: [
    CachedProducts,
    CachedIngredients,
    ProductRecipes,
    LocalShifts,
    SyncOutbox,
    LocalSettings,
    CachedOrders,
    CachedSales,
  ],
)
class PosDatabase extends _$PosDatabase {
  PosDatabase() : super(driftDatabase(name: 'salvajada_pos'));

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2)
        await m.addColumn(cachedProducts, cachedProducts.modifiersJson);
      if (from < 3) await m.createTable(productRecipes);
      if (from < 4) {
        await m.database.customStatement(
          "ALTER TABLE cached_orders ADD COLUMN recipe_snapshot_json TEXT NOT NULL DEFAULT '[]'",
        );
        await m.database.customStatement(
          'ALTER TABLE cached_orders ADD COLUMN ingredients_consumed INTEGER NOT NULL DEFAULT 0',
        );
      }
      if (from < 5) await m.createTable(cachedSales);
      if (from < 6) {
        await m.addColumn(cachedOrders, cachedOrders.source);
        await m.addColumn(cachedOrders, cachedOrders.address);
      }
    },
  );

  Future<void> cacheCatalog(List<Map<String, dynamic>> items) async {
    await transaction(() async {
      await delete(cachedProducts).go();
      await delete(productRecipes).go();
      for (final item in items) {
        await into(cachedProducts).insertOnConflictUpdate(
          CachedProductsCompanion.insert(
            productId: item['id'].toString(),
            name: item['name'].toString(),
            category: item['category'].toString(),
            description: Value(item['description']?.toString() ?? ''),
            price: int.parse(item['price'].toString()),
            modifiersJson: Value(jsonEncode(item['modifiers'] ?? const [])),
            active: Value(item['active'] == true || item['available'] == 1),
          ),
        );
        final recipe = item['recipe'];
        if (recipe is List) {
          for (final row in recipe) {
            if (row is Map) {
              await into(productRecipes).insertOnConflictUpdate(
                ProductRecipesCompanion.insert(
                  productId: item['id'].toString(),
                  ingredientId: row['ingredient_id'].toString(),
                  quantity: double.parse(row['quantity'].toString()),
                  unitCost: double.parse(row['unit_cost'].toString()),
                ),
              );
            }
          }
        }
      }
    });
  }

  Stream<List<CachedProduct>> watchCatalog() =>
      (select(cachedProducts)..where((product) => product.active)).watch();

  Future<void> cacheIngredients(List<Map<String, dynamic>> items) async {
    await transaction(() async {
      await delete(cachedIngredients).go();
      for (final item in items) {
        await into(cachedIngredients).insertOnConflictUpdate(
          CachedIngredientsCompanion.insert(
            ingredientId: item['id'].toString(),
            name: item['name'].toString(),
            unit: item['unit'].toString(),
            quantity: Value(double.parse(item['quantity'].toString())),
            minimum: Value(double.parse(item['minimum'].toString())),
            unitCost: Value(double.parse(item['unit_cost'].toString())),
          ),
        );
      }
    });
  }

  Stream<List<CachedIngredient>> watchIngredients() => (select(
    cachedIngredients,
  )..orderBy([(item) => OrderingTerm.asc(item.name)])).watch();

  Future<CachedProduct?> getProduct(String id) => (select(
    cachedProducts,
  )..where((product) => product.productId.equals(id))).getSingleOrNull();

  Future<LocalShift?> getOpenShift() async {
    final current = await (select(
      localSettings,
    )..where((setting) => setting.key.equals('user_id'))).getSingleOrNull();
    if (current == null) return null;
    return (select(localShifts)
          ..where(
            (shift) =>
                shift.state.equals('ABIERTO') &
                shift.userId.equals(current.value),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> saveShift({
    required String id,
    required String userId,
    required int openingCash,
    required DateTime openedAt,
  }) async {
    await into(localShifts).insertOnConflictUpdate(
      LocalShiftsCompanion.insert(
        shiftId: id,
        userId: userId,
        openingCash: openingCash,
        openedAt: openedAt.toUtc(),
      ),
    );
  }

  Future<void> closeShiftLocal(String id) =>
      (update(localShifts)..where((shift) => shift.shiftId.equals(id))).write(
        const LocalShiftsCompanion(state: Value('CERRADO')),
      );

  Future<void> saveOrders(List<Map<String, dynamic>> items) async {
    await transaction(() async {
      for (final item in items) {
        if (item['source'] == 'POS') {
          await into(cachedSales).insertOnConflictUpdate(
            CachedSalesCompanion.insert(
              sourceId: item['source_id'].toString(),
              customerName: item['customer_name'].toString(),
              phone: Value(item['phone']?.toString() ?? ''),
              status: Value(item['status']?.toString() ?? 'ENTREGADO'),
              productsJson: jsonEncode(item['products'] ?? const []),
              total: int.parse(item['total'].toString()),
              paymentMethod: item['payment_method'].toString(),
              modality: Value(item['modality']?.toString() ?? 'LOCAL'),
              address: Value(item['address']?.toString() ?? ''),
              createdAt:
                  DateTime.tryParse(item['created_at'].toString())?.toUtc() ??
                  DateTime.now().toUtc(),
            ),
          );
          continue;
        }
        await into(cachedOrders).insertOnConflictUpdate(
          CachedOrdersCompanion.insert(
            orderId: Value(int.parse(item['id'].toString())),
            customerName: item['customer_name'].toString(),
            phone: item['phone'].toString(),
            status: item['status'].toString(),
            productsJson: jsonEncode(item['products'] ?? const []),
            total: int.parse(item['total'].toString()),
            paymentMethod: item['payment_method'].toString(),
            source: Value(item['source']?.toString() ?? 'WHATSAPP'),
            address: Value(item['address']?.toString() ?? ''),
            recipeSnapshotJson: Value(
              item['recipe_snapshot']?.toString() ?? '[]',
            ),
            ingredientsConsumed: Value(
              item['ingredients_consumed'] == 1 ||
                  item['ingredients_consumed'] == true,
            ),
            createdAt:
                DateTime.tryParse(item['created_at'].toString())?.toUtc() ??
                DateTime.now().toUtc(),
          ),
        );
      }
    });
  }

  Stream<List<CachedOrder>> watchOrders() => (select(
    cachedOrders,
  )..orderBy([(order) => OrderingTerm.desc(order.createdAt)])).watch();

  Stream<List<CachedSale>> watchSales() => (select(
    cachedSales,
  )..orderBy([(sale) => OrderingTerm.desc(sale.createdAt)])).watch();

  Future<void> enqueue(String type, Map<String, Object?> payload) async {
    await into(syncOutbox).insert(
      SyncOutboxCompanion.insert(
        clientUuid: const Uuid().v4(),
        eventType: type,
        payloadJson: jsonEncode(payload),
        createdAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<String> recordSale({
    required String shiftId,
    required List<Map<String, Object?>> items,
    required int cash,
    required int transfer,
    required int deliveryFee,
    required String modality,
    required String customer,
    required String address,
    required String note,
  }) async {
    final uuid = const Uuid().v4();
    await transaction(() async {
      final shift =
          await (select(localShifts)..where(
                (row) =>
                    row.shiftId.equals(shiftId) & row.state.equals('ABIERTO'),
              ))
              .getSingleOrNull();
      if (shift == null) throw StateError('El turno ya no está abierto.');
      final stock = <String, double>{};
      final snapshots = <Map<String, Object?>>[];
      final localProducts = <Map<String, Object?>>[];
      var subtotal = 0;
      for (final item in items) {
        final id = item['product_id'].toString();
        final quantity = (item['quantity'] as num).toInt();
        final product = await getProduct(id);
        if (product == null || quantity < 1)
          throw StateError('Producto o cantidad no válida.');
        final modifiers = product.modifiersJson.isEmpty
            ? const <dynamic>[]
            : jsonDecode(product.modifiersJson) as List<dynamic>;
        final selected = (item['modifier_ids'] as List? ?? const [])
            .map((v) => v.toString())
            .toSet();
        final extra = modifiers
            .whereType<Map<String, dynamic>>()
            .where((m) => selected.contains(m['id']))
            .fold<int>(0, (s, m) => s + (m['price'] as num? ?? 0).round());
        final modifierNames = modifiers
            .whereType<Map<String, dynamic>>()
            .where((m) => selected.contains(m['id']))
            .map((m) => m['name'].toString())
            .toList();
        final recipe = (select(
          productRecipes,
        )..where((row) => row.productId.equals(id))).get();
        final rows = await recipe;
        final recipeSnapshot = <Map<String, Object?>>[];
        var lineCost = 0.0;
        for (final row in rows) {
          final needed = row.quantity * quantity;
          stock[row.ingredientId] = (stock[row.ingredientId] ?? 0) + needed;
          lineCost += needed * row.unitCost;
          recipeSnapshot.add({
            'ingredient_id': row.ingredientId,
            'quantity': row.quantity,
            'unit_cost': row.unitCost,
          });
        }
        subtotal += (product.price + extra) * quantity;
        snapshots.add({
          ...item,
          'name': product.name,
          'category': product.category,
          'quantity': quantity,
          'price': product.price + extra,
          'modifiers': modifierNames,
          'unit_price': product.price,
          'modifier_price_snapshot': extra,
          'recipe_snapshot': recipeSnapshot,
          'cost_snapshot': lineCost / quantity,
        });
        localProducts.add({
          'productId': id,
          'name': product.name,
          'category': product.category,
          'quantity': quantity,
          'price': product.price + extra,
          'modifiers': modifierNames,
        });
      }
      final total = subtotal + deliveryFee;
      if (cash + transfer != total)
        throw StateError('El pago no coincide con el total.');
      for (final entry in stock.entries) {
        final ingredient =
            await (select(cachedIngredients)
                  ..where((row) => row.ingredientId.equals(entry.key)))
                .getSingleOrNull();
        if (ingredient == null || ingredient.quantity < entry.value)
          throw StateError(
            'No hay suficiente ${ingredient?.name ?? 'inventario'}.',
          );
        await (update(
          cachedIngredients,
        )..where((row) => row.ingredientId.equals(entry.key))).write(
          CachedIngredientsCompanion(
            quantity: Value(ingredient.quantity - entry.value),
          ),
        );
      }
      final payload = <String, Object?>{
        'shift_id': shiftId,
        'items': snapshots,
        'cash': cash,
        'transfer': transfer,
        'delivery_fee': deliveryFee,
        'modality': modality,
        'customer': customer,
        'address': address,
        'note': note,
      };
      final createdAt = DateTime.now().toUtc();
      await into(cachedSales).insertOnConflictUpdate(
        CachedSalesCompanion.insert(
          sourceId: uuid,
          customerName: customer.isEmpty ? 'Venta de mostrador' : customer,
          phone: const Value(''),
          status: const Value('ENTREGADO'),
          productsJson: jsonEncode(localProducts),
          total: total,
          paymentMethod: cash > 0 && transfer > 0
              ? 'Mixto'
              : cash > 0
              ? 'Efectivo'
              : 'Transferencia',
          modality: Value(modality),
          address: Value(address),
          createdAt: createdAt,
        ),
      );
      await into(syncOutbox).insert(
        SyncOutboxCompanion.insert(
          clientUuid: uuid,
          eventType: 'sale',
          payloadJson: jsonEncode(payload),
          createdAt: createdAt,
        ),
      );
    });
    return uuid;
  }

  Future<void> recordInventoryMovement(
    String type,
    Map<String, Object?> payload,
  ) async {
    final id = const Uuid().v4();
    await transaction(() async {
      final ingredientId = payload['ingredient_id'].toString();
      final quantity = (payload['quantity'] as num).toDouble();
      final current =
          await (select(cachedIngredients)
                ..where((row) => row.ingredientId.equals(ingredientId)))
              .getSingleOrNull();
      if (current == null || quantity == 0)
        throw StateError(
          'No se encontró el insumo o la cantidad no es válida.',
        );
      final purchase = type == 'inventory_purchase';
      final delta = purchase
          ? quantity.abs()
          : type == 'inventory_loss'
          ? -quantity.abs()
          : quantity;
      final updated = current.quantity + delta;
      if (updated < 0)
        throw StateError('El ajuste excede el stock local disponible.');
      var unitCost = current.unitCost;
      if (purchase) {
        final total = (payload['total_cost'] as num?)?.toDouble() ?? 0;
        if (total <= 0)
          throw StateError(
            'El costo total de la compra debe ser mayor a cero.',
          );
        unitCost =
            (current.quantity * current.unitCost + total) /
            (current.quantity + delta);
      }
      await (update(
        cachedIngredients,
      )..where((row) => row.ingredientId.equals(ingredientId))).write(
        CachedIngredientsCompanion(
          quantity: Value(updated),
          unitCost: Value(unitCost),
        ),
      );
      await into(syncOutbox).insert(
        SyncOutboxCompanion.insert(
          clientUuid: id,
          eventType: type,
          payloadJson: jsonEncode(payload),
          createdAt: DateTime.now().toUtc(),
        ),
      );
    });
  }

  Future<void> recordOrderStatus({
    required int orderId,
    required String status,
    required String reason,
    String? shiftId,
  }) async {
    final id = const Uuid().v4();
    await transaction(() async {
      final order = await (select(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).getSingleOrNull();
      if (order == null || !['RECIBIDO', 'TERMINADO'].contains(order.status))
        throw StateError('Este pedido no permite cambios de estado.');
      var consumed = order.ingredientsConsumed;
      if (status == 'TERMINADO' && !consumed) {
        final recipe = jsonDecode(order.recipeSnapshotJson) as List<dynamic>;
        for (final item in recipe) {
          if (item is! Map) continue;
          final ingredientId = item['ingredient_id'].toString();
          final needed = (item['quantity'] as num).toDouble();
          final ingredient =
              await (select(cachedIngredients)
                    ..where((row) => row.ingredientId.equals(ingredientId)))
                  .getSingleOrNull();
          if (ingredient == null || ingredient.quantity < needed)
            throw StateError(
              'No hay suficiente inventario para terminar este pedido.',
            );
          await (update(
            cachedIngredients,
          )..where((row) => row.ingredientId.equals(ingredientId))).write(
            CachedIngredientsCompanion(
              quantity: Value(ingredient.quantity - needed),
            ),
          );
        }
        consumed = recipe.isNotEmpty;
      }
      await (update(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).write(
        CachedOrdersCompanion(
          status: Value(status),
          ingredientsConsumed: Value(consumed),
        ),
      );
      await into(syncOutbox).insert(
        SyncOutboxCompanion.insert(
          clientUuid: id,
          eventType: 'whatsapp_status',
          payloadJson: jsonEncode({
            'order_id': orderId,
            'status': status,
            'reason': reason,
            'shift_id': shiftId,
          }),
          createdAt: DateTime.now().toUtc(),
        ),
      );
    });
  }

  Future<String> recordWhatsappDelivery({
    required int orderId,
    required String shiftId,
  }) async {
    final id = const Uuid().v4();
    await transaction(() async {
      final order = await (select(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).getSingleOrNull();
      if (order == null || order.status != 'TERMINADO')
        throw StateError('Solo se puede entregar un pedido terminado.');
      var consumed = order.ingredientsConsumed;
      if (!consumed) {
        final recipe = jsonDecode(order.recipeSnapshotJson) as List<dynamic>;
        for (final item in recipe) {
          if (item is! Map) continue;
          final ingredientId = item['ingredient_id'].toString();
          final needed = (item['quantity'] as num).toDouble();
          final ingredient =
              await (select(cachedIngredients)
                    ..where((row) => row.ingredientId.equals(ingredientId)))
                  .getSingleOrNull();
          if (ingredient == null || ingredient.quantity < needed)
            throw StateError(
              'No hay inventario suficiente para entregar el pedido.',
            );
          await (update(
            cachedIngredients,
          )..where((row) => row.ingredientId.equals(ingredientId))).write(
            CachedIngredientsCompanion(
              quantity: Value(ingredient.quantity - needed),
            ),
          );
        }
        consumed = recipe.isNotEmpty;
      }
      await (update(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).write(
        CachedOrdersCompanion(
          status: const Value('ENTREGADO'),
          ingredientsConsumed: Value(consumed),
        ),
      );
      await into(syncOutbox).insert(
        SyncOutboxCompanion.insert(
          clientUuid: id,
          eventType: 'whatsapp_delivered',
          payloadJson: jsonEncode({'order_id': orderId, 'shift_id': shiftId}),
          createdAt: DateTime.now().toUtc(),
        ),
      );
    });
    return id;
  }

  Future<String> recordLocalDelivery({
    required int orderId,
    required String shiftId,
    required int cash,
    required int transfer,
  }) async {
    final id = const Uuid().v4();
    await transaction(() async {
      final order = await (select(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).getSingleOrNull();
      if (order == null ||
          order.source != 'LOCAL' ||
          order.status != 'TERMINADO') {
        throw StateError('Solo se puede entregar un pedido local terminado.');
      }
      if (cash < 0 || transfer < 0 || cash + transfer != order.total) {
        throw StateError('El pago no coincide con el total del pedido.');
      }
      final method = cash > 0 && transfer > 0
          ? 'Mixto'
          : cash > 0
          ? 'Efectivo'
          : 'Transferencia';
      await (update(
        cachedOrders,
      )..where((row) => row.orderId.equals(orderId))).write(
        CachedOrdersCompanion(
          status: const Value('ENTREGADO'),
          paymentMethod: Value(method),
        ),
      );
      await into(syncOutbox).insert(
        SyncOutboxCompanion.insert(
          clientUuid: id,
          eventType: 'local_delivered',
          payloadJson: jsonEncode({
            'order_id': orderId,
            'shift_id': shiftId,
            'cash': cash,
            'transfer': transfer,
          }),
          createdAt: DateTime.now().toUtc(),
        ),
      );
    });
    return id;
  }

  Future<SyncOutboxData?> syncEvent(String id) => (select(
    syncOutbox,
  )..where((event) => event.clientUuid.equals(id))).getSingleOrNull();

  Future<List<SyncOutboxData>> pendingEvents({int limit = 100}) {
    return (select(syncOutbox)
          ..where((event) => event.syncedAt.isNull())
          ..orderBy([(event) => OrderingTerm.asc(event.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<Map<String, dynamic>?> latestCloseResult() async {
    final row =
        await (select(syncOutbox)
              ..where((event) => event.eventType.equals('shift_close'))
              ..orderBy([(event) => OrderingTerm.desc(event.createdAt)])
              ..limit(1))
            .getSingleOrNull();
    if (row?.serverResultJson == null) return null;
    try {
      return jsonDecode(row!.serverResultJson!) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Stream<int> watchPendingCount() {
    final count = syncOutbox.clientUuid.count();
    return (selectOnly(syncOutbox)
          ..addColumns([count])
          ..where(syncOutbox.syncedAt.isNull()))
        .map((row) => row.read(count) ?? 0)
        .watchSingle();
  }

  Stream<List<SyncOutboxData>> watchSyncErrors() =>
      (select(syncOutbox)
            ..where(
              (event) => event.syncedAt.isNull() & event.lastError.isNotNull(),
            )
            ..orderBy([(event) => OrderingTerm.desc(event.createdAt)])
            ..limit(8))
          .watch();

  Future<void> markSynced(
    Iterable<String> ids, {
    Map<String, Object?>? results,
  }) async {
    if (ids.isEmpty) return;
    for (final id in ids) {
      await (update(
        syncOutbox,
      )..where((event) => event.clientUuid.equals(id))).write(
        SyncOutboxCompanion(
          syncedAt: Value(DateTime.now().toUtc()),
          serverResultJson: Value(
            results?[id] == null ? null : jsonEncode(results![id]),
          ),
          lastError: const Value(null),
        ),
      );
    }
  }

  Future<void> setError(String id, String message) =>
      (update(syncOutbox)..where((event) => event.clientUuid.equals(id))).write(
        SyncOutboxCompanion(lastError: Value(message)),
      );
}
