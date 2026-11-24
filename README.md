# CiviGo

> *"Cuando tú actúas, la ciudad progresa."*

**CiviGo** es una aplicación móvil (Flutter) de participación ciudadana para reportar incidencias urbanas (baches, fugas de agua/gas, postes caídos, semáforos dañados, basuras, etc.) en **Cartagena, Colombia**. El ciudadano toma una foto, la app captura su ubicación GPS, una IA (Gemini) analiza la imagen y sugiere clasificación, entidad responsable, riesgo y descripción; el reporte queda guardado en Supabase y puede ser gestionado por administradores y entidades.

---

## Tabla de contenido

1. [Stack tecnológico](#stack-tecnológico)
2. [Arquitectura](#arquitectura)
3. [Estructura de carpetas](#estructura-de-carpetas)
4. [Roles y permisos](#roles-y-permisos)
5. [Navegación y rutas](#navegación-y-rutas)
6. [Flujos principales](#flujos-principales)
7. [Backend (Supabase)](#backend-supabase)
8. [Catálogos de dominio](#catálogos-de-dominio)
9. [Estado de los módulos](#estado-de-los-módulos)
10. [Puesta en marcha](#puesta-en-marcha)
11. [Deuda técnica y recomendaciones](#deuda-técnica-y-recomendaciones)

---

## Stack tecnológico

| Área | Tecnología |
|---|---|
| Framework | Flutter (Dart SDK `^3.9.2`), versión app `0.1.0` |
| Estado / DI | `flutter_riverpod` 3 + `riverpod_annotation` / `riverpod_generator` (code-gen con `build_runner`) |
| Navegación | `go_router` (con `ShellRoute` y redirect por sesión) |
| Backend | Supabase (`supabase_flutter`): Auth, Postgres (tablas + RPC), Storage, Edge Functions |
| IA | Google Gemini `gemini-2.5-flash` desde la Edge Function `analyze_incident` (Deno/TypeScript) |
| Mapas / GPS | `google_maps_flutter`, `geolocator` |
| Cámara | `image_picker` |
| HTTP | `dio` (cliente configurado; el flujo actual usa Supabase directamente) |
| Conectividad | `connectivity_plus` |
| UI | `salomon_bottom_bar`, `carousel_slider`, `flutter_spinkit`, `dropdown_button2`, `top_snackbar_flutter`, `syncfusion_flutter_datagrid` |
| Validación | `email_validator` |
| Localización | `intl` con `es_CO` |

Plataformas con scaffolding: Android, iOS, Web, Windows, macOS, Linux (el foco real es **Android/iOS**; el manifiesto Android declara permisos de cámara y ubicación fina/aproximada).

---

## Arquitectura

Organización **feature-first** con separación tipo *Clean Architecture* (`data` / `domain` / `presentation`) y **Riverpod** como gestor de estado e inyección de dependencias.

```
UI (pages/widgets)
   │  ref.watch / ref.read
   ▼
Providers Riverpod (Notifier: estado inmutable + copyWith)
   │
   ▼
Repository (interfaz en domain, implementación en data)
   │
   ▼
Supabase (Auth · Postgres/RPC · Storage · Edge Functions)
```

- Cada *notifier* (`@riverpod class X extends _$X`) mantiene un `State` inmutable con `copyWith`.
- El cliente de Supabase se inyecta mediante `dbClientProvider` ([lib/core/db/db_client.dart](lib/core/db/db_client.dart)); los repositorios se exponen como providers (`incidentRepositoryProvider`, `aiRepositoryProvider`, `authRepositoryProvider`, `userRepositoryProvider`).
- Los errores se mapean a `AppError` / `AppErrorEntity` ([features/shared/](lib/features/shared/)) y se muestran como banner global (success / warning / error) en el `DashboardPage` mediante `uiAlertsProvider`.
- Los archivos `*.g.dart` son **generados** por `build_runner`; no se editan a mano.

---

## Estructura de carpetas

```
lib/
├── main.dart                     # Init: locale es_CO, Supabase.initialize, ProviderScope, MaterialApp.router
├── config/
│   ├── api_config/               # Env (dev/prod) y baseUrl de Dio
│   ├── app_config/               # Nombre, lema, colores corporativos, tema
│   └── route_config/route_paths.dart   # Nombres y paths de todas las rutas
├── core/
│   ├── db/db_client.dart         # Provider del SupabaseClient
│   ├── network/                  # Dio + chequeo de conectividad
│   └── router/router_provider.dart     # GoRouter + guards de autenticación
└── features/
    ├── auth/         # Login, registro, estado de sesión
    ├── home/         # Landing pública con slider de bienvenida
    ├── dashboard/    # Shell: AppBar, bottom bar, menú de perfil, inicio con resumen
    ├── reports/      # ⭐ Núcleo: incidencias (crear, listar, detalle, IA, cambio de estado)
    ├── map/          # Mapa de incidentes (Google Maps)
    ├── users/        # Administración de usuarios (admin)
    ├── entities/     # Listado de entidades (UI, datos mock)
    ├── reports2/     # Pantalla "Reportes" de admin (UI en construcción)
    └── shared/       # Servicios (cámara, GPS), widgets UI reutilizables, manejo de errores, utils

supabase/
├── config.toml
└── functions/analyze_incident/   # Edge Function (Deno) que llama a Gemini
assets/                           # Imágenes (ilustraciones de incidentes, avatares, ícono)
```

Cada feature sigue (con distinto nivel de completitud) `data/{models,remote,repository}`, `domain/{entities,repository,usecase}` y `presentation/{pages,providers,widgets}`.

---

## Roles y permisos

Definidos en `UserRole` ([menu_item_model.dart](lib/features/dashboard/presentation/models/menu_item_model.dart)): **`citizen`**, **`admin`**, **`entity`**.

El rol se guarda en los *metadata* del usuario de Supabase Auth (`user_metadata.role`) al registrarse (por defecto `citizen`; `entity` además guarda `entity_id`).

| Capacidad | Ciudadano | Entidad | Admin |
|---|:-:|:-:|:-:|
| Registrarse / iniciar sesión | ✅ | ✅ | ✅ |
| Crear incidencias (con IA) | ✅ | ✅ | ✅ |
| Ver incidencias, mapa, perfil | ✅ | ✅ | ✅ |
| Cambiar estado de una incidencia | ❌ | ✅ | ✅ |
| Menú lateral: Usuarios, Entidades, Reportes | ❌ | ❌ | ✅ |
| Crear usuarios con rol (incl. entidad) | ❌ | ❌ | ✅ |

Los ítems de menú se filtran con `allowedRoles` ([menu_items.dart](lib/features/dashboard/presentation/config/menu_items.dart)).

> ⚠️ Los permisos hoy se aplican principalmente **en la UI**. La seguridad real debe garantizarla Supabase (RLS + validación de rol dentro de las RPC). Ver [Deuda técnica](#deuda-técnica-y-recomendaciones).

---

## Navegación y rutas

Configurada en [router_provider.dart](lib/core/router/router_provider.dart). El `GoRouter` se reconstruye al cambiar `authProvider.isLogin`.

**Guard (`redirect`):**
- **No autenticado** → solo puede estar en `/` (home), `/login`, `/register`; cualquier otra ruta redirige a `/`.
- **Autenticado** → si intenta ir a `/`, `/login` o `/register` redirige a `/dashboard`.

| Path | Pantalla | Contenedor |
|---|---|---|
| `/` | `HomePage` (slider de bienvenida) | pública |
| `/login` | `AuthPage` | pública |
| `/register` | `RegisterPage` | pública |
| `/dashboard` | `DashboardBody` (resumen + actividad reciente) | ShellRoute |
| `/incidents` | `IncidentsPage` (lista) | ShellRoute |
| `/incident_detail/:id` | `IncidentDetailPage` | ShellRoute |
| `/map_incidents` | `MapIncidents` | ShellRoute |
| `/profile` | `MenuPage` (perfil/menú, logout) | ShellRoute |
| `/users` → `/users/new_user` | `UsersPage` → `NewUserPage` | ShellRoute (admin) |
| `/entities` | `EntitiesPage` | ShellRoute (admin) |
| `/reports` | `ReportPage` | ShellRoute (admin) |
| `/new_incident` | `NewIncidentPage` (wizard de 3 pasos) | fuera del shell |
| `/new_incident/photo_preview` | `PhotoPreviewPage` | sub-ruta |
| `/new_incident/analyze_ia` | `AnalyzeAiPage` | sub-ruta |

El `ShellRoute` envuelve las pantallas internas en `DashboardPage` (AppBar con logo/avatar, bottom bar *Inicio · Incidentes · Mapa · Perfil* y banner global de alertas). Todas las transiciones son *fade*.

---

## Flujos principales

### 1. Autenticación

```
Home (/)  ──►  Login (/login)  ──►  signInWithPassword (Supabase Auth)
   │                                     │ ok → authProvider.isLogin = true
   │                                     ▼
   └──►  Registro (/register)        redirect automático → /dashboard
          signUp(email, password,
          data: {name, role: citizen})
```

- `Auth` notifier ([auth_provider.dart](lib/features/auth/presentation/providers/auth_provider.dart)) expone `signIn`, `signUp`, `logOut`, `clearError`; su `AuthState` contiene `isLogin`, `isSearching`, `succesRegister`, `user`, `error`.
- Tras un registro público exitoso `isLogin` queda en `false` (el usuario debe iniciar sesión).
- Si un **admin** crea un usuario (se pasa `role`), se conserva `isLogin` para no cerrar su sesión.
- Los errores de Supabase se traducen con `mapAuthError` ([failure_mapper_sb.dart](lib/features/shared/presentation/failure_mapper_sb.dart)).

### 2. Crear una incidencia (flujo central)

Wizard de 3 pasos en `/new_incident` (`PageView` sin scroll manual, controlado por `NewIncident.currentStep`).

```
PASO 1 — Evidencia
  Step1  "Abrir cámara"
    └─ Step1.takePhotoFlow
         1. CameraService.takePhoto()        (image_picker, cámara trasera, calidad 80)
         2. getCurrentLocation()             (geolocator: valida GPS y permisos)
         3. NewIncident.setLocation / setImagePath
         4. push /new_incident/photo_preview ── ¿repetir foto? → vuelve al paso 1
         5. confirmar → push /new_incident/analyze_ia

ANÁLISIS IA — AnalyzeAiPage (al montarse llama analyzeIncident())
  a. IncidentRepository.uploadImage(File)    → Storage bucket "incidencias" (nombre = timestamp.jpg) → URL pública
  b. AiRepository.analyzeImage(url)          → Edge Function "analyze_incident"
  c. Edge Function descarga la imagen, la envía a Gemini y devuelve JSON:
       { categoria, riesgo (1-3), descripcion, entidad, is_incident }
  d. Se guarda en el estado: aiCategory, aiEntity, priority, description, incidentImageUrl, isIncident
  e. is_incident == true  → pop + nextStep()  (pasa al paso 2)
     is_incident == false → pantalla "No se detectó una incidencia" (animación detenida, botón Finalizar)
     error de red/IA      → se detiene y retorna false

PASO 2 — Clasificación y detalle (Step2, Form validado con keyForm)
  El usuario revisa/ajusta: clasificación, entidad designada, prioridad, "¿ocurre ahora?" (Sí/No), descripción.
  Se muestran las sugerencias de la IA junto a los campos.
  Botón "Finalizar" → saveIncident():
     IncidentRepository.createIncident → INSERT en tabla "incidencias" con user_id = usuario actual
     payload: state='pending', latitude, longitude, priority, happens_now,
              description, incident_image_url, clasification_id, designated_entity_id
  ok → nextStep()

PASO 3 — Confirmación
  Step3 "¡Todo listo! Tu reporte se ha creado correctamente." → Finalizar (pop)
```

El estado del wizard vive en `NewIncidentState` ([new_incident_state.dart](lib/features/reports/data/models/new_incident_state.dart)); `reset()` lo limpia.

### 3. Consulta de incidencias

```
Dashboard / IncidentsPage
  └─ Incidents.getIncidents()  →  supabase.rpc('get_incidents')
        calcula: amount (total), pending (state=='pending'), inProgress (state=='process')
        alimenta: tarjetas "MIS REPORTES" del dashboard y lista /incidents

Detalle (/incident_detail/:id)
  └─ IncidentDetail.setIncident(id): busca el id en la lista ya cargada (incidentsProvider) — no hace nueva consulta
```

La visibilidad (propias vs. todas) depende de lo que devuelva la RPC `get_incidents` en el servidor.

### 4. Gestión de estado de una incidencia (entidad / admin)

```
IncidentDetailPage (rol = entity | admin ve los controles)
  └─ NewIncident.updateStatus(id, status) → supabase.rpc('update_incident_status',
        { p_incident_id, p_status })  → bool
  ok → alerta global "Incidencia actualizada correctamente."
```

Estados (`estados` en [constants.dart](lib/features/reports/domain/constants.dart)): `pending` (Pendiente) → `process` (En gestión) → `resolved` (Resuelto).

### 5. Administración de usuarios (admin)

```
/users  UsersPage
  └─ Users (AsyncNotifier) → UserDatasource.getUsers() → rpc('get_auth_users')
     tabla (Syncfusion DataGrid) con nombre, correo, rol (Ciudadano / Admin / Entidad)
  └─ "Nuevo usuario" → /users/new_user (NewUserPage)
       Step1: nombre, rol, entidad (solo si rol = entity)
       Step2: credenciales
       → Auth.signUp(data, role: ...) → supabase.auth.signUp con metadata {name, role, entity_id?}
```

### 6. Mapa

`MapIncidents` muestra Google Maps con buscador y chips de filtro por tipo (Todos, Baches, Basura, Alumbrado, Fugas, Otros), y tarjeta de detalle del incidente seleccionado. Usa la lista de `incidentsProvider`.

---

## Backend (Supabase)

Proyecto Supabase vinculado (ver `supabase/.temp/project-ref`). Recursos que la app consume:

| Recurso | Tipo | Uso |
|---|---|---|
| `auth` | Auth | Registro/login con email+password; rol en `user_metadata` |
| `incidencias` | Tabla | INSERT (crear) y DELETE (`deleteIncident`) |
| `get_incidents` | RPC | Listado de incidencias (con datos unidos) |
| `update_incident_status` | RPC | Cambia el estado; `(p_incident_id int, p_status text) → bool` |
| `get_auth_users` | RPC | Lista usuarios de `auth.users` (admin) |
| `incidencias` | Storage bucket (público) | Fotos de evidencia |
| `analyze_incident` | Edge Function | Análisis de imagen con Gemini |

**Columnas de `incidencias` que escribe la app:** `user_id`, `state`, `latitude`, `longitude`, `priority`, `happens_now`, `description`, `incident_image_url`, `clasification_id`, `designated_entity_id` (+ `id`, `created_at` generados por la BD).

> El esquema SQL (tablas, RPC, políticas RLS) **no está versionado** en el repositorio (solo `config.toml` y la función). Se recomienda exportarlo a `supabase/migrations/`.

### Edge Function `analyze_incident`

[supabase/functions/analyze_incident/index.ts](supabase/functions/analyze_incident/index.ts)

- **Entrada:** `{ "imageUrl": "<url pública>" }`
- **Proceso:** descarga la imagen → base64 → `gemini-2.5-flash` con `responseMimeType: application/json` y un prompt que restringe la respuesta a las listas cerradas de entidades y clasificaciones.
- **Salida:** `{ "response": "<string JSON>" }` con `categoria`, `riesgo` (1 Bajo, 2 Medio, 3 Alto), `descripcion` (3–4 líneas), `entidad`, `is_incident` (`false` si la foto no es una incidencia real).
- **Error:** HTTP 500 `{ "error": "..." }`.
- **Secreto requerido:** `GEMINI_API_KEY` (variable de entorno de la función).
- **Despliegue:** `supabase functions deploy analyze_incident`

---

## Catálogos de dominio

Definidos de forma estática en [constants.dart](lib/features/reports/domain/constants.dart) (los `id` deben coincidir con la BD).

- **Entidades (20):** Afinia, Aguas de Cartagena, Veolia, Pacaribe, Surtigas, Movilidad Cartagena, Policía Nacional, Bomberos Cartagena, DADIS, EPA Cartagena, Alcaldía de Cartagena, Espacio Público, Protección Animal, Defensa Civil, Cruz Roja Colombiana, Secretaría de Educación, Secretaría de Infraestructura, Guardacostas, Ministerio de Ambiente, Gestión del Riesgo.
- **Clasificaciones (10):** Infraestructura, Seguridad, Movilidad, Servicios públicos, Medio ambiente, Comunidad, Emergencias, Mascotas y animales, Espacio urbano, Otros reportes.
- **Prioridad:** 1 Baja (azul) · 2 Media (naranja) · 3 Crítica (rojo).
- **Estados:** `pending` · `process` · `resolved`.

> Los nombres de entidades/clasificaciones están duplicados en el prompt de la Edge Function; si se modifica un catálogo hay que actualizar ambos sitios.

---

## Estado de los módulos

| Módulo | Estado |
|---|---|
| Auth (login/registro/logout) | ✅ Funcional |
| Crear incidencia + IA | ✅ Funcional |
| Listado / detalle / cambio de estado | ✅ Funcional |
| Gestión de usuarios (admin) | ✅ Funcional |
| Dashboard | 🟡 Resumen real (`MIS REPORTES`); "Actividad reciente" usa datos de ejemplo |
| Mapa | 🟡 UI lista; filtros por tipo y marcadores en desarrollo |
| Entidades | 🟡 UI con datos mock |
| Reportes (`reports2`) | 🟡 UI sin lógica |
| Configuración (`/configuration`) | ⬜ Ruta declarada en el menú, sin pantalla registrada |
| Persistencia local / offline (`LocalDataSources`, Drift) | ⬜ Stub (`UnimplementedError`) |
| Capa `domain/usecase` de reports | 🟡 Existe pero el flujo actual usa el repositorio directamente |
| Tests | ⬜ No hay carpeta `test/` |

---

## Puesta en marcha

### Requisitos
- Flutter con Dart `^3.9.2`
- Cuenta/proyecto Supabase (con tablas, RPC, bucket `incidencias` y Edge Function desplegada)
- API key de Google Maps configurada en Android/iOS
- Supabase CLI (para desplegar la función)

### Instalación

```bash
flutter pub get

# Generar código de Riverpod (*.g.dart) — dejar en watch mientras se desarrolla
dart run build_runner watch -d
# o una sola vez:
dart run build_runner build -d

flutter run
```

### Íconos de la app
```bash
dart run flutter_launcher_icons
```
(configuración en [flutter_launcher_icons.yaml](flutter_launcher_icons.yaml))

### Edge Function (IA)
```bash
supabase secrets set GEMINI_API_KEY=<tu_clave>
supabase functions deploy analyze_incident
```
Re-desplegar cada vez que cambie `index.ts`.

### Permisos
Android declara `CAMERA`, `ACCESS_FINE_LOCATION` y `ACCESS_COARSE_LOCATION`. En iOS asegúrate de tener las claves `NSCameraUsageDescription` y `NSLocationWhenInUseUsageDescription` en `Info.plist`.

---

## Deuda técnica y recomendaciones

1. **Credenciales en el código:** `main.dart` contiene la URL y la `anonKey` de Supabase. La anon key es pública por diseño, pero conviene moverla a `--dart-define` / `.env` por entorno. **Toda la seguridad debe descansar en RLS**.
2. **Autorización solo en cliente:** los roles se leen de `user_metadata` (editable por el propio usuario si no se protege). Validar el rol en el servidor (RPC con `SECURITY DEFINER` + comprobación, o `app_metadata`) y activar RLS en `incidencias`.
3. **Bucket público:** las fotos se sirven por URL pública y la Edge Function las descarga por URL. Evaluar *signed URLs* si hay datos sensibles.
4. **Esquema no versionado:** añadir `supabase/migrations/` con tablas, RPC y políticas.
5. **Código duplicado/placeholder:** `features/dashboard/{data,domain}` replica plantillas de `auth` (mismos nombres `AuthRepository`); `reports2` duplica `entities` (`date_provider`, `get_category`, etc.); `Api.baseUrl` y `AuthRemoteDataSource` apuntan a un endpoint de ejemplo no usado.
6. **Catálogos hardcodeados** y duplicados (app + prompt de IA): moverlos a tablas de BD.
7. **Manejo de errores:** varios `catch` descartan la causa (`saveIncident`, `analyzeIncident`) y hay `print` de depuración en `router_provider` y `auth_provider`; unificar con `uiAlertsProvider`.
8. **Detalle de incidencia:** depende de que la lista esté cargada; si se entra por deep link directo no habrá datos. Considerar un fetch por id.
9. **Rol leído de `identities[0].identityData`** en `incident_detail.dart`; es más robusto usar `user.userMetadata['role']` como en el resto de la app.
10. **Tests:** no existen; priorizar pruebas de notifiers (`NewIncident`, `Auth`) y repositorios con mocks de Supabase.
11. Archivo con nombre defectuoso: `card_mediaevidence_widget.dart.dart`; typo en `incidents_reposirory_impl.dart`.
