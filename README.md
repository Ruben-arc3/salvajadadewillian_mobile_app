# La Salvajada de Willian · App móvil

Aplicación móvil de punto de venta y administración creada para **el restaurante La Salvajada de Willian**, ubicado en el barrio El Dorado. Está pensada para que el equipo gestione desde el celular la operación diaria del restaurante: pedidos, ventas, caja e inventario.

La app trabaja con una base de datos local para permitir que las operaciones sigan guardándose cuando la conexión se interrumpe. Cuando vuelve internet, sincroniza los cambios pendientes con el backend del restaurante en Cloudflare Workers y D1.

## Funciones

- **Inicio:** resumen de ingresos del día, pedidos por estado, conexión y pedidos recientes.
- **Pedidos:** consulta los pedidos recibidos por WhatsApp y los pedidos locales; permite terminarlos, cancelarlos y registrar su entrega.
- **Ventas:** registra ventas rápidas y consulta los ingresos, gastos y reportes. Incluye un historial permanente de ventas entregadas, con el detalle de productos, forma de pago, cliente y canal de origen.
- **Caja:** apertura y cierre de turnos, base inicial, gastos, aportes y registro de pagos en efectivo, transferencia o pago mixto.
- **Inventario:** administra insumos, existencias, recetas, modificadores y movimientos.
- **Administración:** herramientas de configuración disponibles según el rol de usuario.
- **Acceso por roles:** contempla los roles `ADMIN` y `CAJERO`.
- **Uso sin conexión:** conserva operaciones en el teléfono y las deja pendientes hasta poder sincronizarlas.

## Tecnologías

- Flutter y Dart para la aplicación Android.
- Drift y SQLite para el almacenamiento local.
- Cloudflare Workers como API del sistema.
- Cloudflare D1 como base de datos remota.
- HTTP y JSON para la comunicación entre la app y el Worker.

## Requisitos

- Flutter SDK compatible con Dart `^3.8.1`.
- Android SDK 36.
- Android NDK `27.0.12077973`.
- Android Gradle Plugin 8.9.1 o posterior compatible con la configuración del proyecto.
- Un emulador Android o un dispositivo con depuración USB para ejecutar la app.

## Ejecutar en desarrollo

Desde esta carpeta:

```bash
flutter pub get
flutter run
```

La app se conecta al Worker configurado en `lib/data/api_client.dart`. Para que las consultas y la sincronización remota funcionen, ese Worker debe estar desplegado y la cuenta debe tener acceso.

## Crear APK de instalación

```bash
flutter build apk --release
```

El archivo se genera en:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Estructura principal

```text
lib/
├── main.dart              # Pantallas y flujos de la aplicación
└── data/
    ├── api_client.dart    # API, autenticación y sincronización
    └── pos_database.dart  # Base local SQLite/Drift y cola offline
assets/
└── logo.png               # Logo del restaurante dentro de la app
android/                   # Configuración para compilar en Android
```

## Seguridad

No guardes tokens de WhatsApp, secretos de Meta, contraseñas administrativas ni archivos de firma privados dentro del repositorio. La app se autentica contra el backend; los secretos del Worker se configuran por separado en Cloudflare.
