import 'package:flutter/widgets.dart';
import 'package:sp_kit/sp_kit.dart';
import 'package:sp_kit/src/localization/app_localize.dart';

/// Language builder
class LocaleRegister<T extends AppLocalize> {
  final List<AppLocalize> _localizeList = [];
  final ValueNotifier<Lang> activeLang = ValueNotifier(Lang.en);
  GlobalKey localKey = GlobalKey();
  AppLocalize? _current;

  LocaleRegister();

  /// Provide accessable language object
  T get l => _current as T;

  /// Register language
  void register(T local) {
    _localizeList.add(local);
    _current ??= _localizeList.first;
  }

  /// change language
  void changeLang(Lang lang) {
    if (activeLang.value != lang) {
      activeLang.value = lang;
      try {
        _current = _localizeList.firstWhere((e) => e.lang == lang) as T;
      } catch (e) {
        throw Exception(
          "Language not found: $lang. Please register language first.",
        );
      }
      localKey = GlobalKey();
    }
  }
}
