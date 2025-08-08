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
  DiContainer get di => DiContainer();
  VmContainer get vm => VmContainer();
}

extension StatefulExtension on StatefulWidget {
  DiContainer get di => DiContainer();
  VmContainer get vm => VmContainer();
}

extension StateExtension on State {
  DiContainer get di => DiContainer();
  VmContainer get vm => VmContainer();
}

extension ChangeNotifierExtension on ChangeNotifier {
  DiContainer get di => DiContainer();
}

/// Language extension
extension LanguageExtension on BuildContext {
  LocalizeInherited get local => LocalizeInherited.of(this);
  T t<T>() => local.register.l as T;
}
