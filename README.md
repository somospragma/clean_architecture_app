# base_stack_cross_platform

This project is a base archetype for Flutter applications implemented with **Clean Architecture**. It is designed to facilitate development by following best practices such as responsibility separation, **Repository** usage, and state management with **Riverpod**.

---

## **Project Structure**

The architecture adheres to Clean Architecture principles, dividing the application into well-defined layers:

```
lib/
├── core/                         # Shared utilities and classes across layers
├── features/
|   └── feature
|       ├── data/                 # Concrete implementations
│       |   └── repositories/     # Repository implementations
|       ├── domain/               # Business rules
│       |   ├── models/           # Pure domain models
│       |   └── usecases/         # Use cases
|       └── presentation/         # UI and state management
│           ├── state/            # State providers (Riverpod)
│           ├── pages/            # Main application views
│           └── widgets/          # Reusable components
├── shared/                       # Components that are used globally throughout the application
└── main.dart                     # Application entry point
```

---

## **Installation and Setup**

1. **Clone the repository:**

   ```bash
   git clone <REPOSITORY_URL>
   cd <PROJECT_NAME>
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the application:**

   ```bash
   flutter run
   ```

---
## **VS Code Plugin**

- [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Awesome Flutter Snippets](https://marketplace.visualstudio.com/items?itemName=Nash.awesome-flutter-snippets)
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [Riverpod Snippets](https://marketplace.visualstudio.com/items?itemName=robert-brunhage.flutter-riverpod-snippets)
