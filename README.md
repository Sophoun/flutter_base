
# Flutter Base

A base library for Flutter projects that provides core functionalities like Dependency Injection, ViewModel management, and Localization.

## Features

* **Dependency Injection:** Simple DI container to manage your app's dependencies.
* **ViewModel:** A container to manage your ViewModels, separating business logic from UI.
* **Localization:** Easy way to handle multi-language support in your app.
* **Utility Extensions:** A set of extensions to simplify your code.

## Getting Started

To use this library, add `flutter_base` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_base:
    git:
      url: https://github.com/Sophoun/flutter_base.git
      ref: main
```

## Usage

### `FlutterBase` Widget

The `FlutterBase` widget is the root of your application. It provides the `DIContainer`, `VmContainer`, and `LocaleRegister` to all widgets down the tree.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();
  final diContainer = DiContainer()
    ..register(MockNet())
    ..registerLazy((c) => MockService(mockNet: c.get<MockNet>()));

  @override
  Widget build(BuildContext context) {
    return FlutterBase(
      locale: LocaleRegister<AppLang>()
        ..register(En(lang: Lang.en))
        ..register(Kh(lang: Lang.km))
        ..changeLang(Lang.km),
      vmContainer: VmContainer()..register(HomeVm()),
      diContainer: diContainer,
      child: MaterialApp.router(routerConfig: appRouter.config()),
    );
  }
}
```

### Localization

1. **Create a language abstract class:**

```dart
abstract class AppLang extends AppLocalize {
  AppLang({required super.lang});

  String appName();
  String count(int count);
  String currentLanguageIs(String lang);
}
```

2. **Create language implementations:**

```dart
// en.dart
class En extends AppLang {
  En({required super.lang});

  @override
  String appName() => "My App";

  @override
  String count(int count) => "Count: $count";

  @override
  String currentLanguageIs(String lang) => "Current language is $lang";
}

// kh.dart
class Kh extends AppLang {
  Kh({required super.lang});

  @override
  String appName() => "កម្មវិធីរបស់ខ្ញុំ";

  @override
  String count(int count) => "ចំនួន៖ $count";

  @override
  String currentLanguageIs(String lang) => "ភាសាបច្ចុប្បន្នគឺ $lang";
}
```

3. **Register your languages in `FlutterBase`:**

```dart
locale: LocaleRegister<AppLang>()
  ..register(En(lang: Lang.en))
  ..register(Kh(lang: Lang.km))
  ..changeLang(Lang.km),
```

4. **Use the translations in your widgets:**

```dart
final t = context.t<AppLang>();
Text(t.appName());
```

5. **Change the language:**

```dart
context.local.register.changeLang(Lang.en);
```

### Dependency Injection (`DIContainer`)

1. **Register your dependencies:**

You can register your dependencies as singletons or lazy singletons.

```dart
final diContainer = DiContainer()
  ..register(MockNet()) // Singleton
  ..registerLazy((c) => MockService(mockNet: c.get<MockNet>())); // Lazy singleton
```

2. **Get your dependencies:**

Use the `getDi<T>()` function to get your registered dependencies.

```dart
late final mockService = getDi<MockService>();
```

### ViewModel (`VmContainer`)

1. **Create a `ChangeNotifier` class for your ViewModel:**

```dart
class HomeVm extends ChangeNotifier {
  late final mockService = getDi<MockService>();

  final counter = ValueNotifier(10);

  void incrementCounter() {
    counter.value++;
    notifyListeners();
  }
}
```

2. **Register your ViewModel in `FlutterBase`:**

```dart
vmContainer: VmContainer()..register(HomeVm()),
```

3. **Get your ViewModel in your widgets:**

Use the `getVm<T>()` function to get your registered ViewModels.

```dart
HomeVm get homeVm => getVm<HomeVm>();
```

### Utility Extensions

This library provides a set of extensions to simplify your code.

* **`ValueNotifierAsWidgetBuilder<T>`:** Converts a `ValueNotifier` to a widget that rebuilds when the value changes.

    ```dart
    homeVm.counter.builder(build: (value) => Text(t.count(value ?? 0)))
    ```

* **`PostLoadingExtension`:** Show or hide a loading indicator.

    ```dart
    postLoading(true); // Show loading
    postLoading(false); // Hide loading
    ```

* **`StatelessExtension`, `StatefulExtension`, `StateExtension`:** Get your dependencies and ViewModels in your widgets without any boilerplate code.

    ```dart
    final homeVm = getVm<HomeVm>();
    final mockService = getDi<MockService>();
    ```

* **`LanguageExtension`:** Access your translations using `context.t<T>()`.

    ```dart
    final t = context.t<AppLang>();
    Text(t.appName());
    ```

* **`showMessage`, `showToast`:** Show a dialog or a toast message.

    ```dart
    showMessage(
      type: MessageDialogType.okCanncel,
      title: "Welcome, to my longest title dialog",
      message: "This is my longest Hello world, Hello world, Hello world, Hello world Hello world!",
      onOk: () {
        showToast("You clicked OK");
      },
      onCancel: () {
        showToast("You clicked Cancel");
      },
    );
    ```

* **`p`:** Access `SharedPreferences` instance.

    ```dart
    p.getString("my_key");
    ```

    In case you want to use it early in your application. Please consider call `init` function in your `main` function.

    ```dart
    void main() {
      Pref.init()
    }
    ```

## Example

The `example` folder contains a sample application demonstrating the usage of this library. To run the example, clone the repository and run the following command from the `example` directory:

```bash
flutter run
```

## License

Copyright 2025 SOPHOUN NHEUM

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
