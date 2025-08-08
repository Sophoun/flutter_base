import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/localization/localize_inherited.dart';

/// Vallue notifier builder function
extension ValueNotifierAsWidgetBuilder<T> on ValueNotifier<T?> {
  /// Converts the ValueNotifier to a Widget that rebuilds when the value changes.
  Widget builder({required Widget Function(T? value) build, Key? key}) {
    return ValueListenableBuilder<T?>(
      valueListenable: this,
      builder: (context, value, child) {
        return build(value);
      },
      key: key,
    );
  }
}

/// Is loading
final isAppLoading = ValueNotifier(false);

/// Post loading value
extension PostLoadingExtension on ChangeNotifier {
  /// Post loading value
  void postLoading(bool loading) {
    isAppLoading.value = loading;
  }
}

///
/// Get di/vm extensions
///
extension StatelessExtension on StatelessWidget {
  T getDi<T>() => DiContainer().get<T>();
  T getVm<T>() => VmContainer().get<T>();
}

extension StatefulExtension on StatefulWidget {
  T getDi<T>() => DiContainer().get<T>();
  T getVm<T>() => VmContainer().get<T>();
}

extension StateExtension on State {
  T getDi<T>() => DiContainer().get<T>();
  T getVm<T>() => VmContainer().get<T>();
}

extension ChangeNotifierExtension on ChangeNotifier {
  T getDi<T>() => DiContainer().get<T>();
}

/// Language extension
extension LanguageExtension on BuildContext {
  LocalizeInherited get local => LocalizeInherited.of(this);
  T t<T>() => local.register.l as T;
}
