`<h1 align="center">
  <br>
  <a href="http://www.amitmerchant.com/electron-markdownify"><img src="https://f.hubspotusercontent20.net/hubfs/2829524/Copia%20de%20LOGOTIPO_original-2.png"></a>
  <br>
  Clean Architecture App
  <br>
</h1>

<h4 align="center">Proyecto base de <a href="https://github.com/karatelabs/karate" target="_blank">Pragma</a>.</h4>

<p align="center">
  <a href="https://docs.flutter.dev/release/archive">
    <img src="https://img.shields.io/badge/Flutter-3.29.0-blue" alt="Flutter">
  </a>
  <a href="https://riverpod.dev/es/">
    <img src="https://img.shields.io/badge/Riverpod-purple" alt="Riverpod">
  </a>
</p>

Este proyecto es un arquetipo base para aplicaciones Flutter implementadas con Clean Architecture. Está diseñado para facilitar el desarrollo siguiendo las mejores prácticas, como la separación de responsabilidades, el uso de Repository Pattern y la gestión de estado con Riverpod.

<p align="center">
  <a href="#topicos">Topicos</a> •`
  <a href="#tecnologias">Tecnologias</a> •
  <a href="#descarga">Descarga</a> •
  <a href="#instalación-y-ejecución">Instalación y ejecución</a> •
  <a href="#autores">Autores</a> •
</p>

## Topicos

* Flutter
* Riverpod

## Tecnologias
### This project required:
- [SDK Flutter] version 3.29.0
- [Dart] version 3.7.0
- [Riverpod] version 2.6.1

## Descarga
Para clonar está aplicación desde la linea de comando:

```bash
git clone https://github.com/sharfe25/clean_architecture_app.git
cd clean_architecture_app
git remote remove origin
git remote add origin URL_DE_TU_NUEVO_REPOSITORIO
git push -u origin master
```
Nota: Asegúrate de reemplazar URL_DE_TU_NUEVO_REPOSITORIO con la URL del repositorio que creaste en tu cuenta de GitHub.

Puedes descargar el proyecto en el enlace [download](https://github.com/sharfe25/clean_architecture_app) 

## Instalación y ejecución

Para ejecutar está aplicación, necesitas [Java JDK](https://www.oracle.com/java/technologies/downloads/) y [Flutter SDK](https://docs.flutter.dev/release/archive) instalados en tu equipo, ten en cuenta que tu IDE puede gestionar la instalación de estos requerimientos. Desde la linea de comando:

### Instalar dependencias
```bash
   flutter pub get
   ```
 ### Ejecutar la aplicación
```bash
   flutter run
   ```
# Tutorial: Uso de Riverpod en el Proyecto

Este proyecto utiliza **Riverpod** como gestor de estado y proveedor de dependencias. En este tutorial, exploraremos cómo se implementa Riverpod en la autenticación y la configuración de la aplicación.

---

## 1. Configuración de Riverpod en la Autenticación

### 1.1. Gestor de Estado para Login (`logInProvider`)

Se utiliza `StateNotifierProvider` para manejar el estado del formulario de inicio de sesión. Esto permite actualizar el estado de manera reactiva y realizar acciones como validación de campos y llamadas a la API.

```dart
final StateNotifierProvider<LogInNotifier, LogInState> logInProvider =
    StateNotifierProvider<LogInNotifier, LogInState>((Ref<LogInState> ref) => LogInNotifier(
          authUsecase: ref.read(authUsecaseProvider),
          router: ref.read(appRouterProvider),
        ));
```

- **`StateNotifierProvider`**: Provee una instancia de `LogInNotifier`, que maneja el estado del login.
- **Dependencias**:
  - `authUsecaseProvider`: Para la lógica de autenticación.
  - `appRouterProvider`: Para la navegación.

### 1.2. Repositorio de Autenticación (`authRepositoryProvider`)

Se define un `Provider` para gestionar la implementación del repositorio de autenticación.

```dart
final Provider<AuthRepositoryImpl> authRepositoryProvider =
    Provider<AuthRepositoryImpl>((Ref<AuthRepositoryImpl> ref) {
  return AuthRepositoryImpl();
});
```

- **`Provider`**: Se usa para crear una instancia del repositorio `AuthRepositoryImpl`.
- **Inyección de Dependencias**: `ref.read(authRepositoryProvider)` permite acceder a la instancia en otros lugares del código.

### 1.3. Caso de Uso (`authUsecaseProvider`)

Se utiliza `Provider.autoDispose` para que la instancia de `AuthUsecase` se destruya cuando no se necesite, optimizando el uso de memoria.

```dart
final AutoDisposeProvider<AuthUsecase> authUsecaseProvider =
    Provider.autoDispose<AuthUsecase>((Ref<AuthUsecase> ref) {
  return AuthUsecase(authRepository: ref.read(authRepositoryProvider));
});
```

- **`autoDispose`**: Libera memoria cuando el provider ya no es usado.
- **Dependencias**: `authRepositoryProvider` para ejecutar las operaciones de autenticación.

---

## 2. Configuración de la Aplicación con Riverpod

### 2.1. Configuración Principal en `MainApp`

Se utiliza `ConsumerWidget` para acceder a los providers dentro del `build`.

```dart
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter appRouter = ref.watch(appRouterProvider);

    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: AppTheme(isDarkmode: false).getTheme(),
          );
        });
  }
}
```

- **`ConsumerWidget`**: Permite leer `appRouterProvider` mediante `ref.watch()`.
- **Inyección de Dependencias**: `GoRouter` se obtiene desde `appRouterProvider`.

### 2.2. Gestión de Rutas con Riverpod y GoRouter

Se utiliza un `Provider` para manejar la configuración de rutas de la aplicación.

```dart
final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref<GoRouter> ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        name: 'logIn',
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const LoginPage(),
      ),
      GoRoute(
        name: 'signUp',
        path: '/signUp',
        builder: (BuildContext context, GoRouterState state) => const SignUpPage(),
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState state) => const HomePage(),
      ),
      GoRoute(
        name: 'resetPassword',
        path: '/resetPassword',
        builder: (BuildContext context, GoRouterState state) => const ResetPasswordPage(),
      ),
    ],
  );
});
```

- **`Provider<GoRouter>`**: Se utiliza para mantener la configuración de rutas accesible desde cualquier parte de la aplicación.
- **Uso en `MainApp`**: `ref.watch(appRouterProvider)` garantiza que los cambios en las rutas se reflejen en la UI.

---

## Conclusión

En este tutorial, hemos visto cómo Riverpod facilita la gestión del estado en el proyecto:

✅ `StateNotifierProvider` para manejar el estado del login.
✅ `Provider` para la inyección de dependencias en el repositorio y el caso de uso.
✅ `Provider<GoRouter>` para la navegación centralizada con `GoRouter`.

Esto mejora la escalabilidad y mantenibilidad del código. ¡Ahora tienes una base sólida para seguir desarrollando con Riverpod! 🚀




## Autores


 [<img src="https://avatars.githubusercontent.com/u/51301940?s=400&u=59904da5265ef21c498b68373ed0bdb3f2c16127&v=4" width=115><br><sub>Sharon Y. Rueda F.</sub>](https://github.com/sharfe25) <br/> 

