# FieldSync Pro 📱⚡

> **Offline-First Field Asset Management & Technical Reporting System**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=flat-square&logo=dart)](https://dart.dev)
[![Laravel](https://img.shields.io/badge/Laravel-11.x-FF2D20?style=flat-square&logo=laravel)](https://laravel.com)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=flat-square)]()

---

## 🧭 Tabla de Contenidos

- [Descripción General](#-descripción-general)
- [Arquitectura del Sistema](#-arquitectura-del-sistema)
- [Stack Tecnológico](#-stack-tecnológico)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Módulos Principales](#-módulos-principales)
- [Base de Datos Local](#-base-de-datos-local)
- [Sync Engine](#-sync-engine)
- [Formularios Dinámicos](#-formularios-dinámicos)
- [Instalación y Setup](#-instalación-y-setup)
- [Variables de Entorno](#-variables-de-entorno)
- [Roadmap](#-roadmap)
- [Contribución](#-contribución)

---

## 📋 Descripción General

**FieldSync Pro** es una solución integral de gestión de activos y reportes técnicos en terreno, diseñada específicamente para entornos con conectividad limitada o nula — subsuelos, zonas rurales, plantas industriales.

El sistema permite a los técnicos realizar auditorías y mantenimientos complejos de forma fluida, garantizando la integridad de los datos mediante una arquitectura **Offline-First**. La aplicación móvil sincroniza de forma inteligente los datos con un núcleo administrativo centralizado cuando la conexión se restablece.

### Casos de Uso Principales

- ✅ Auditorías de equipos en zonas sin cobertura
- ✅ Inspecciones de vehículos con evidencia fotográfica y firma digital
- ✅ Mantenimiento preventivo con historial de activos
- ✅ Reportes técnicos formales generados automáticamente
- ✅ Gestión multi-técnico con resolución de conflictos

---

## 🏗️ Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────┐
│                  MOBILE APP (Flutter)                   │
│                                                         │
│  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │  Dashboard  │  │   Assets     │  │  Inspections  │  │
│  │   Screen    │  │  Explorer    │  │  (Dynamic Form│  │
│  └─────────────┘  └──────────────┘  └───────────────┘  │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │              Drift / SQLite (Local DB)          │    │
│  │  users │ assets │ inspections │ outbox │ media  │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │               Sync Engine                       │    │
│  │  ConnectivityService → OutboxQueue → API Call   │    │
│  │  WorkManager (background) + Foreground trigger  │    │
│  └─────────────────────────────────────────────────┘    │
└────────────────────────┬────────────────────────────────┘
                         │ HTTPS / REST
                         │ JWT (Sanctum)
                         ▼
┌─────────────────────────────────────────────────────────┐
│                  BACKEND (Laravel 11)                   │
│                                                         │
│  ┌──────────────┐  ┌─────────────┐  ┌───────────────┐  │
│  │  Auth API    │  │  Sync API   │  │  Admin Panel  │  │
│  │  (Sanctum)   │  │  /api/v1/   │  │  (Filament)   │  │
│  └──────────────┘  └─────────────┘  └───────────────┘  │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │           MySQL / PostgreSQL                    │    │
│  └─────────────────────────────────────────────────┘    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │        Laravel Reverb (WebSockets)              │    │
│  │        Real-time dashboard updates              │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

### Principios de Diseño

| Principio | Implementación |
|-----------|----------------|
| **Offline-First** | Drift/SQLite como fuente de verdad local |
| **Outbox Pattern** | Cola de salida para operaciones pendientes |
| **Optimistic UI** | La UI responde inmediatamente, sync en background |
| **Conflict Resolution** | `updated_at` + `device_id` para detección de conflictos |
| **Resumable Uploads** | Subida por chunks para medios en redes inestables |

---

## 🛠️ Stack Tecnológico

### Mobile (Flutter)

| Categoría | Paquete | Versión |
|-----------|---------|---------|
| State Management | `hooks_riverpod` | ^2.5.1 |
| Base de datos local | `drift` + `sqlite3_flutter_libs` | ^2.18.0 |
| HTTP Client | `dio` | ^5.4.3 |
| Conectividad | `connectivity_plus` | ^6.0.3 |
| Background tasks | `workmanager` | ^0.5.2 |
| Navegación | `go_router` | ^14.2.7 |
| Almacenamiento seguro | `flutter_secure_storage` | ^9.2.2 |
| Compresión de imágenes | `flutter_image_compress` | ^2.3.0 |
| Cámara | `image_picker` | ^1.1.2 |
| Firma digital | `syncfusion_flutter_signaturepad` | ^25.1.41 |
| IDs únicos | `uuid` | ^4.4.0 |
| Code generation | `build_runner` + `freezed` | — |

### Backend (Laravel)

| Categoría | Herramienta |
|-----------|-------------|
| Framework | Laravel 11 |
| Autenticación | Laravel Sanctum |
| WebSockets | Laravel Reverb |
| Panel Admin | Filament v3 |
| PDF Generation | Laravel DomPDF |
| Queue | Laravel Horizon + Redis |
| Storage | S3 / Backblaze B2 |

---

## 📁 Estructura del Proyecto

```
fieldsync_pro/
│
├── lib/
│   ├── core/
│   │   ├── database/           # Drift: tablas, DAOs, database.dart
│   │   │   ├── tables.dart
│   │   │   ├── database.dart
│   │   │   └── daos/
│   │   │       ├── inspections_dao.dart
│   │   │       ├── assets_dao.dart
│   │   │       ├── outbox_dao.dart
│   │   │       └── media_dao.dart
│   │   ├── network/
│   │   │   ├── dio_client.dart
│   │   │   ├── auth_interceptor.dart
│   │   │   └── connectivity_service.dart
│   │   ├── sync/
│   │   │   ├── sync_engine.dart
│   │   │   ├── outbox_processor.dart
│   │   │   └── media_uploader.dart
│   │   ├── storage/
│   │   │   └── secure_storage_service.dart
│   │   └── utils/
│   │       ├── device_info.dart
│   │       └── constants.dart
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── dashboard/
│   │   ├── assets/
│   │   ├── inspection/
│   │   │   └── presentation/
│   │   │       └── widgets/
│   │   │           └── form_renderer/   # Motor de formularios dinámicos
│   │   └── sync_queue/
│   │
│   ├── shared/
│   │   ├── widgets/
│   │   ├── theme/
│   │   └── router/
│   │
│   └── main.dart
│
├── android/
├── ios/
├── assets/
│   ├── images/
│   └── icons/
├── test/
└── pubspec.yaml
```

---

## 🗄️ Base de Datos Local

El esquema local está diseñado para funcionar completamente sin internet.

```
┌──────────┐     ┌───────────────┐     ┌──────────────────┐
│  users   │     │    assets     │     │   inspections    │
│──────────│     │───────────────│     │──────────────────│
│ id       │     │ id            │     │ id               │
│ remoteId │     │ remoteId      │     │ localUuid (UUID) │
│ name     │     │ name          │     │ assetId (FK)     │
│ email    │     │ type          │     │ technicianId     │
│ deviceId │     │ location      │     │ formId           │
└──────────┘     │ lastServiceAt │     │ formVersion      │
                 │ syncedAt      │     │ formData (JSON)  │
                 └───────────────┘     │ syncStatus       │
                                       │ createdAt        │
                                       │ updatedAt        │
                                       └──────────────────┘

┌─────────────────────┐     ┌──────────────────────┐
│    outbox_queue     │     │     media_files       │
│─────────────────────│     │──────────────────────│
│ id                  │     │ id                   │
│ entityType          │     │ localUuid            │
│ entityId (UUID)     │     │ inspectionUuid       │
│ payload (JSON)      │     │ localPath            │
│ operation (C/U/D)   │     │ compressedPath       │
│ attempts            │     │ remoteUrl            │
│ deviceId            │     │ isUploaded           │
│ status              │     │ type (photo/sign)    │
│ createdAt           │     │ createdAt            │
│ lastAttemptAt       │     └──────────────────────┘
└─────────────────────┘

┌─────────────────────┐
│   form_templates    │
│─────────────────────│
│ id                  │
│ formId              │
│ version             │
│ title               │
│ schema (JSON)       │
│ isActive            │
│ cachedAt            │
└─────────────────────┘
```

### Estados de Sincronización

```
 [local] ──► [pending] ──► [synced]
                │
                └──► [conflict]  ──► resolución manual o automática
```

---

## ⚙️ Sync Engine

El motor de sincronización opera en dos modos:

### Foreground (al abrir la app)
```
ConnectivityService detecta red disponible
        │
        ▼
SyncEngine.run()
        ├─► OutboxProcessor: sube registros pendientes
        │         ├─ Backoff exponencial (1s → 2s → 4s → ...)
        │         ├─ Máximo 5 intentos → marca como "failed"
        │         └─ Asocia y sube MediaFiles del registro
        │
        └─► Pull: descarga cambios del servidor
                  (assets, catálogos, form templates nuevos)
```

### Background (WorkManager)
```
WorkManager ejecuta SyncEngine.run() cada 15 minutos
        │
        ├─ Respeta Doze Mode de Android
        ├─ Configurable: WiFi-only o cualquier red
        └─ Registra resultado en log local
```

### Resolución de Conflictos

Cuando dos técnicos editan el mismo activo offline:

```
Servidor recibe dos versiones del mismo registro
        │
        ├─ Compara: updated_at + device_id
        ├─ Si server_version > client_version → server gana (last-write-wins)
        ├─ Si timestamps muy cercanos → marca como "conflict"
        └─ Notifica al admin en el panel web para resolución manual
```

---

## 📝 Formularios Dinámicos

Los formularios de inspección son 100% dinámicos: los campos, validaciones y lógica condicional vienen definidos desde el servidor en formato JSON.

### Estructura del Schema

```json
{
  "form_id": "auto_check_v1",
  "version": 2,
  "title": "Revisión de Vehículo",
  "sections": [
    {
      "id": "sec_general",
      "title": "Datos Generales",
      "fields": [
        {
          "id": "tire_pressure",
          "type": "number",
          "label": "Presión de neumáticos",
          "hint": "Ingrese en PSI",
          "required": true,
          "validation": { "min": 20, "max": 50 }
        },
        {
          "id": "damage_found",
          "type": "boolean",
          "label": "¿Se encontraron daños?",
          "required": true
        },
        {
          "id": "damage_description",
          "type": "textarea",
          "label": "Descripción del daño",
          "required": true,
          "visible_when": {
            "field": "damage_found",
            "equals": true
          }
        }
      ]
    }
  ]
}
```

### Tipos de Campo Soportados

| Tipo | Widget Flutter |
|------|---------------|
| `text` | `TextFormField` |
| `textarea` | `TextFormField` multiline |
| `number` | `TextFormField` (keyboardType numeric) |
| `select` | `DropdownButtonFormField` |
| `multiselect` | Chips seleccionables |
| `boolean` | `SwitchListTile` |
| `date` | `DatePicker` |
| `photo` | `ImagePicker` + preview grid |
| `signature` | `SfSignaturePad` |

---

## 🚀 Instalación y Setup

### Prerequisitos

- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- Android Studio / Xcode
- JDK 17+

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-org/fieldsync_pro.git
cd fieldsync_pro

# 2. Instalar dependencias
flutter pub get

# 3. Generar código (Drift, Riverpod, Freezed)
dart run build_runner build --delete-conflicting-outputs

# 4. Configurar variables de entorno (ver sección siguiente)
cp .env.example .env

# 5. Correr la app
flutter run
```

### Permisos Requeridos

**Android** (`android/app/src/main/AndroidManifest.xml`):
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
```

**iOS** (`ios/Runner/Info.plist`):
```xml
<key>NSCameraUsageDescription</key>
<string>FieldSync necesita acceso a la cámara para adjuntar evidencia fotográfica.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>FieldSync necesita acceso a fotos para adjuntar evidencia.</string>
```

---

## 🔐 Variables de Entorno

Crear un archivo `.env` en la raíz (nunca commitear al repo):

```env
API_BASE_URL=https://api.tudominio.com
API_VERSION=v1
JWT_EXPIRY_DAYS=30
SYNC_INTERVAL_MINUTES=15
MAX_SYNC_ATTEMPTS=5
MAX_PHOTO_SIZE_KB=800
ENABLE_BACKGROUND_SYNC=true
```

---

## 🗺️ Roadmap

### v1.0 — MVP (En desarrollo)
- [x] Arquitectura Offline-First con Drift
- [x] Esquema de base de datos local
- [x] Definición de formularios dinámicos
- [ ] Auth híbrido (online/offline)
- [ ] Sync Engine con Outbox Pattern
- [ ] Form Renderer dinámico
- [ ] Dashboard con estado de sync
- [ ] Explorador de activos
- [ ] Captura de fotos y firma digital

### v1.1
- [ ] Subida resumable de archivos (chunks)
- [ ] Modo offline con indicador visual claro
- [ ] Historial de sincronizaciones
- [ ] Filtros avanzados en explorador de activos

### v1.2
- [ ] Soporte multi-idioma (i18n)
- [ ] Modo oscuro
- [ ] Notificaciones push (nuevas tareas asignadas)
- [ ] Exportar reporte PDF desde la app

### Backend (Laravel) — Paralelo
- [ ] API RESTful con Sanctum
- [ ] Endpoint de sync masivo con transacciones
- [ ] Panel admin con Filament
- [ ] Dashboard en tiempo real (Laravel Reverb)
- [ ] Generación de PDFs
- [ ] Resolución de conflictos

---

## 🤝 Contribución

```bash
# Crear rama para nueva feature
git checkout -b feature/nombre-de-la-feature

# Asegurarse que el código pasa el análisis
flutter analyze

# Correr tests antes de hacer PR
flutter test

# Push y abrir Pull Request
git push origin feature/nombre-de-la-feature
```

### Convenciones de Commits

```
feat:     nueva funcionalidad
fix:      corrección de bug
refactor: refactorización de código
docs:     cambios en documentación
test:     agregar o modificar tests
chore:    tareas de mantenimiento
```

---

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver [LICENSE](LICENSE) para más detalles.

---

<div align="center">

**FieldSync Pro** — Construido con ❤️ usando Flutter + Laravel

*Para entornos donde la conexión no es una garantía, pero el trabajo sí lo es.*

</div>
