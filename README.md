# Flutter Base

A foundational library for Flutter applications, designed to streamline development by providing a robust framework for dependency injection, state management (via ViewModels), localization, and responsive UI. It includes a collection of utility extensions to reduce boilerplate and simplify common Flutter patterns.

## ✨ Features

- **Dependency Injection:** A simple yet powerful DI container to manage your application's dependencies as singletons or lazy singletons.
- **ViewModel Management:** A dedicated container for managing `ChangeNotifier` instances, effectively separating business logic from the UI.
- **Localization:** An intuitive system for implementing multi-language support, allowing for easy registration and switching of languages.
- **Responsive UI:** Built-in support for creating responsive user interfaces that adapt to different screen sizes using `ScreenUtil`.
- **Utility Extensions:** A rich set of extensions for `BuildContext`, `ValueNotifier`, and more, to write cleaner and more concise code.
- **Simplified Preferences:** Easy access to `SharedPreferences` for persistent key-value storage.
- **Built-in Dialogs & Toasts:** Quickly display common UI elements like alerts and toasts with minimal code.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `^3.9.0` or higher
- Dart SDK: `^3.9.0` or higher

### Installation

Add `flutter_base` to your `pubspec.yaml` dependencies. It is recommended to use the Git dependency to ensure you have the latest version.

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_base:
    git:
      url: https://github.com/Sophoun/flutter_base.git
      ref: main # Or specify a specific tag/commit
```

Then, run `flutter pub get` to install the package.

##  usage

### 1. Root Widget Setup (`FlutterBase`)

Wrap your root widget with `FlutterBase` to provide the necessary containers (`DIContainer`, `VmContainer`, `LocaleRegister`) and screen utility initialization to the entire widget tree.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:your_app/di_setup.dart';
import 'package:your_app/lang_setup.dart';
import 'package:your_app/vm_setup.dart';
import 'package:your_app/router.dart';

void main() async {
  // Ensure SharedPreferences is initialized if you access it before runApp()
  await Pref.init(); 
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return FlutterBase(
      // (Optional) Set the design size for responsive UI
      designSize: const Size(360, 690), 
      
      // Register your dependencies
      diContainer: setupDI(), 
      
      // Register your ViewModels
      vmContainer: setupVM(),
      
      // Configure localization
      locale: setupLocale(),
      
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Flutter Base Example',
      ),
    );
  }
}
```

### 2. Localization

#### Define Language Contracts

Create an abstract class that defines the translation keys for your app.

```dart
// lib/lang/app_lang.dart
abstract class AppLang extends AppLocalize {
  AppLang({required super.lang});

  String get appName;
  String count(int count);
  String currentLanguageIs(String lang);
}
```

#### Create Language Implementations

Provide concrete implementations for each supported language.

```dart
// lib/lang/en.dart
class En extends AppLang {
  En() : super(lang: Lang.en);

  @override
  String get appName => "My App";

  @override
  String count(int count) => "Count: $count";

  @override
  String currentLanguageIs(String lang) => "Current language is $lang";
}

// lib/lang/kh.dart
class Kh extends AppLang {
  Kh() : super(lang: Lang.km);

  @override
  String get appName => "កម្មវិធីរបស់ខ្ញុំ";

  @override
  String count(int count) => "ចំនួន៖ $count";

  @override
  String currentLanguageIs(String lang) => "ភាសាបច្ចុប្បន្នគឺ $lang";
}
```

#### Register and Use Translations

Register your languages in the `FlutterBase` widget and access them in your UI.

```dart
// Setup locale
LocaleRegister<AppLang> setupLocale() {
  return LocaleRegister<AppLang>()
    ..register(En())
    ..register(Kh())
    ..changeLang(Lang.km); // Set initial language
}

// In your widget:
final t = context.t<AppLang>();
Text(t.appName);

// To change the language:
context.local.register.changeLang(Lang.en);
```

### 3. Dependency Injection (`DIContainer`)

Register services and access them from anywhere in your app.

```dart
// Setup DI
DIContainer setupDI() {
  return DIContainer()
    ..register(MockNet()) // Singleton
    ..registerLazy((c) => MockService(mockNet: c.get<MockNet>())); // Lazy Singleton
}

// In your class (e.g., a ViewModel or another service):
late final mockService = inject<MockService>();
```

### 4. ViewModel (`VmContainer`)

Manage your UI state with `ChangeNotifier`.

#### Create a ViewModel

```dart
class HomeVm extends ChangeNotifier {
  late final _mockService = inject<MockService>();
  final counter = ValueNotifier(0);

  void increment() {
    counter.value++;
    // notifyListeners() is not needed for ValueNotifier updates
  }
}
```

#### Register and Access the ViewModel

```dart
// Setup ViewModels
VmContainer setupVM() {
  return VmContainer()..register(HomeVm());
}

// In your widget:
final homeVm = getVm<HomeVm>();

// Use the ValueNotifier.builder extension for efficient UI updates
homeVm.counter.builder(
  build: (value) => Text(t.count(value ?? 0)),
)
```

### 5. Utility Extensions

#### Responsive UI

Design your UI for a specific screen size, and it will scale automatically.

```dart
// Initialize in FlutterBase
// designSize: const Size(360, 690),

// Use in widgets
Container(
  width: 150.w, // Scales based on screen width
  height: 200.h, // Scales based on screen height
  padding: EdgeInsets.all(16.w),
  child: Text(
    "Responsive Text",
    style: TextStyle(fontSize: 18.sp), // Scales font size
  ),
);
```

#### Dialogs and Toasts

Show feedback to the user with simple function calls.

```dart
// Show a confirmation dialog
showMessage(
  type: MessageDialogType.okCancel,
  title: "Confirm Action",
  message: "Are you sure you want to proceed?",
  onOk: () => showToast("Action confirmed!"),
  onCancel: () => showToast("Action cancelled."),
);
```

#### SharedPreferences (`p`)

Access `SharedPreferences` easily. Remember to call `Pref.init()` in `main()`.

```dart
// Save a value
await p.setString('user_name', 'Gemini');

// Read a value
final userName = p.getString('user_name');
```

### 6. Responsive Layouts (Mobile & Tablet)

The library includes a powerful `ResponsiveLayout` widget that works with the `FlutterBase` configuration to render different widgets for mobile, tablet, and desktop layouts. It can also enforce a specific aspect ratio for mobile and tablet views, ensuring your layouts look consistent.

#### Configure Aspect Ratios

In your `FlutterBase` widget, you can optionally provide `mobileAspectRatio` and `tabletAspectRatio`.

```dart
// In your main application setup
FlutterBase(
  // Default is 9 / 16
  mobileAspectRatio: 9 / 16, 
  
  // Default is 4 / 3
  tabletAspectRatio: 4 / 3, 
  
  child: MyApp(),
);
```

#### Use the `ResponsiveLayout` Widget

Use the `ResponsiveLayout` widget to build different UI for different screen sizes. The widget automatically applies the configured aspect ratio for mobile and tablet layouts.

```dart
import 'package:flutter_base/flutter_base.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responsive Page")),
      body: ResponsiveLayout(
        mobile: MobileView(),
        tablet: TabletView(),
        desktop: DesktopView(), // Optional
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This view will be constrained to the mobileAspectRatio
    return Container(color: Colors.red, child: Center(child: Text("Mobile")));
  }
}

class TabletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This view will be constrained to the tabletAspectRatio
    return Container(color: Colors.green, child: Center(child: Text("Tablet")));
  }
}

class DesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Desktop view does not have an aspect ratio applied by default
    return Container(color: Colors.blue, child: Center(child: Text("Desktop")));
  }
}
```

## Example Project


The `example` directory contains a complete Flutter application demonstrating all the features of this library. To run it, navigate to the `example` folder and execute:

```bash
flutter run
```

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

*Copyright (c) 2025 SOPHOUN NHEUM*