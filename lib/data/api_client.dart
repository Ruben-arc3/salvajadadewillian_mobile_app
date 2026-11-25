import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'pos_database.dart';

class ApiClient {
  ApiClient({http.Client? client, FlutterSecureStorage? secureStorage})
    : _client = client ?? http.Client(),
      _secureStorage = secureStorage ?? const FlutterSecureStorage();

  static final Uri _baseUri = Uri.parse(
    'https://bot-restaurante-whatsapp.rubenx544.workers.dev',
  );
  final http.Client _client;
  final FlutterSecureStorage _secureStorage;

  Future<Map<String, dynamic>> login(String username, String pin) async {
    final response = await _client.post(
      _baseUri.resolve('/api/auth/login'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username.trim(), 'pin': pin}),
    );
    final data = _decode(response);
    if (response.statusCode >= 400) {
      throw ApiException(
        data['message']?.toString() ?? 'No se pudo iniciar sesión.',
      );
    }
    await _secureStorage.write(
      key: 'session_token',
      value: data['token'] as String?,
    );
    await _secureStorage.write(
      key: 'user_id',
      value: data['user_id'] as String?,
    );
    await _secureStorage.write(
      key: 'user_name',
      value: data['name'] as String?,
    );
    await _secureStorage.write(
      key: 'user_role',
      value: data['role'] as String?,
    );
    return data;
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();
  }

  Future<String?> get token => _secureStorage.read(key: 'session_token');
  Future<String?> get role => _secureStorage.read(key: 'user_role');
  Future<String?> get userName => _secureStorage.read(key: 'user_name');
  Future<String?> get userId => _secureStorage.read(key: 'user_id');

  Future<Map<String, dynamic>> dashboard() async {
    final response = await _request('GET', '/api/pos/dashboard');
    return _decode(response);
  }

  Future<Map<String, dynamic>> audit() async =>
      _decode(await _request('GET', '/api/pos/audit'));

  Future<Map<String, dynamic>> reports({String? start, String? end}) async {
    final query = <String, String>{
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    };
    final path = Uri(
      path: '/api/pos/reports',
      queryParameters: query.isEmpty ? null : query,
    ).toString();
    return _decode(await _request('GET', path));
  }

  Future<Map<String, dynamic>> createProduct(
    Map<String, Object?> product,
  ) async =>
      _decode(await _request('POST', '/api/admin/products', body: product));

  Future<List<Map<String, dynamic>>> adminProducts() async {
    final data = _decode(await _request('GET', '/api/admin/products'));
    return (data['products'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<Map<String, dynamic>> createUser(Map<String, Object?> user) async =>
      _decode(await _request('POST', '/api/admin/users', body: user));

  Future<Map<String, dynamic>> createIngredient(
    Map<String, Object?> ingredient,
  ) async => _decode(
    await _request('POST', '/api/admin/ingredients', body: ingredient),
  );

  Future<Map<String, dynamic>> saveRecipe(Map<String, Object?> recipe) async =>
      _decode(await _request('POST', '/api/admin/recipes', body: recipe));

  Future<Map<String, dynamic>> saveModifier(
    Map<String, Object?> modifier,
  ) async =>
      _decode(await _request('POST', '/api/admin/modifiers', body: modifier));

  Future<List<Map<String, dynamic>>> catalog() async {
    final response = await _request('GET', '/api/pos/catalog');
    final data = _decode(response);
    return (data['products'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<List<Map<String, dynamic>>> orders() async {
    final response = await _request('GET', '/api/pos/orders');
    final data = _decode(response);
    if (response.statusCode >= 400) {
      throw ApiException(
        data['message']?.toString() ??
            'No se pudieron consultar los pedidos en D1.',
      );
    }
    return (data['orders'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<List<Map<String, dynamic>>> salesHistory() async {
    final response = await _request('GET', '/api/pos/sales-history');
    final data = _decode(response);
    return (data['sales'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<Map<String, dynamic>> createLocalOrder(
    Map<String, Object?> order,
  ) async {
    final response = await _request(
      'POST',
      '/api/pos/orders/local',
      body: order,
    );
    final data = _decode(response);
    if (response.statusCode >= 400) {
      throw ApiException(
        data['message']?.toString() ?? 'No se pudo guardar el pedido local.',
      );
    }
    return data;
  }

  Future<List<Map<String, dynamic>>> inventory() async {
    final response = await _request('GET', '/api/pos/inventory');
    final data = _decode(response);
    return (data['inventory'] as List<dynamic>? ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  Future<void> sync(PosDatabase database) async {
    final pending = await database.pendingEvents();
    if (pending.isEmpty) return;
    late final http.Response response;
    late final Map<String, dynamic> data;
    try {
      response = await _request(
        'POST',
        '/api/sync',
        body: {
          'events': pending
              .map(
                (event) => {
                  'client_uuid': event.clientUuid,
                  'type': event.eventType,
                  'payload': jsonDecode(event.payloadJson),
                  'created_at': event.createdAt.toUtc().toIso8601String(),
                },
              )
              .toList(),
        },
      );
      data = _decode(response);
      if (response.statusCode >= 400) {
        throw ApiException(
          data['message']?.toString() ?? 'No se pudo sincronizar.',
        );
      }
    } catch (error) {
      final message = error.toString();
      for (final event in pending) {
        await database.setError(event.clientUuid, message);
      }
      rethrow;
    }
    final accepted = (data['accepted'] as List<dynamic>? ?? const [])
        .whereType<String>()
        .toList();
    final results = <String, Object?>{};
    for (final item in (data['results'] as List<dynamic>? ?? const [])) {
      if (item is Map<String, dynamic> && item['client_uuid'] is String) {
        results[item['client_uuid'] as String] = item;
      }
    }
    await database.markSynced(accepted, results: results);
    for (final item in (data['rejected'] as List<dynamic>? ?? const [])) {
      if (item is Map<String, dynamic> && item['client_uuid'] is String) {
        await database.setError(
          item['client_uuid'] as String,
          item['message']?.toString() ?? 'Error al sincronizar.',
        );
      }
    }
  }

  Future<http.Response> _request(
    String method,
    String path, {
    Object? body,
  }) async {
    final sessionToken = await token;
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (sessionToken != null) headers['Authorization'] = 'Bearer $sessionToken';
    final uri = _baseUri.resolve(path);
    try {
      return switch (method) {
        'GET' =>
          await _client
              .get(uri, headers: headers)
              .timeout(const Duration(seconds: 12)),
        'POST' =>
          await _client
              .post(uri, headers: headers, body: jsonEncode(body))
              .timeout(const Duration(seconds: 20)),
        _ => throw UnsupportedError('Método HTTP no soportado: $method'),
      };
    } on TimeoutException {
      throw ApiException(
        'La conexión tardó demasiado. Los datos locales siguen guardados.',
      );
    } on http.ClientException {
      throw ApiException(
        'Sin conexión con el servidor. La operación sigue pendiente de sincronizar.',
      );
    }
  }

  Map<String, dynamic> _decode(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        if (response.statusCode >= 400) {
          throw ApiException(
            decoded['message']?.toString() ??
                'El servidor respondió HTTP ${response.statusCode}.',
          );
        }
        return decoded;
      }
      throw const ApiException(
        'El servidor no devolvió un objeto JSON. Despliega el Worker y aplica las migraciones D1 pendientes (incluida 0008).',
      );
    } on FormatException {
      throw ApiException(
        'El Worker respondió algo que no es JSON (HTTP ${response.statusCode}). Despliega el Worker y aplica las migraciones D1 pendientes (incluida 0008).',
      );
    }
  }

  void close() => _client.close();
}

class SyncCoordinator {
  SyncCoordinator(this.api, this.database);

  final ApiClient api;
  final PosDatabase database;
  StreamSubscription<List<ConnectivityResult>>? _connectivity;
  Timer? _periodic;
  Future<void>? _current;

  void start() {
    _connectivity = Connectivity().onConnectivityChanged.listen(
      (_) => syncNow(),
    );
    _periodic = Timer.periodic(const Duration(seconds: 25), (_) => syncNow());
    syncNow();
  }

  Future<void> syncNow() {
    if (_current != null) return _current!;
    final task = api
        .sync(database)
        .catchError((_) {})
        .whenComplete(() => _current = null);
    _current = task;
    return task;
  }

  Future<void> dispose() async {
    _periodic?.cancel();
    await _connectivity?.cancel();
  }
}

class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
  @override
  String toString() => message;
}
