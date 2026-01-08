import 'package:flutter/widgets.dart';
import 'package:sp_kit/sp_kit.dart';

// ignore: must_be_immutable
class LocalizeInherited extends InheritedWidget {
  LocalizeInherited({super.key, required this.register, required Widget child})
    : super(
        child: ValueListenableBuilder(
          valueListenable: register.activeLang,
          builder: (context, value, _) =>
              Container(key: register.localKey, child: child),
        ),
      );

  final LocaleRegister register;

  static LocalizeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocalizeInherited>()!;
  }

  /// Short cut to get current language.
  Lang get lang => register.activeLang.value;

  @override
  bool updateShouldNotify(covariant LocalizeInherited oldWidget) {
    return oldWidget.register.activeLang.value != register.activeLang.value;
  }
}
