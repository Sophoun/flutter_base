import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/localization/app_localize.dart';

/// Help renender key
GlobalKey _activeLangKey = GlobalKey();

/// Active language
final ValueNotifier<Lang> _activeLang = ValueNotifier(Lang.en);

// ignore: must_be_immutable
class LocalizeInherited extends InheritedWidget {
  LocalizeInherited({
    super.key,
    required Lang lang,
    required Widget child,
    required List<AppLocalize> localizeList,
  }) : _localizeList = localizeList,
       _currentLocal = localizeList.firstWhere((e) => e.lang == lang),
       super(
         child: ValueListenableBuilder(
           valueListenable: _activeLang,
           builder: (context, value, _) =>
               Container(key: _activeLangKey, child: child),
         ),
       ) {
    // Set current language
    _activeLang.value = lang;
  }

  /// List of languages
  final List<AppLocalize> _localizeList;

  /// Hold current language
  AppLocalize _currentLocal;

  /// Provide accessable language object
  AppLocalize get l => _currentLocal;

  static LocalizeInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocalizeInherited>()!;
  }

  /// Change language
  void changeLang(Lang lang) {
    if (_currentLocal.lang != lang) {
      final foundLocal = _localizeList.where((e) => e.lang == lang);
      if (foundLocal.isEmpty) {
        throw Exception("Language not found $lang");
      }
      _currentLocal = foundLocal.first;
      _activeLangKey = GlobalKey();
      _activeLang.value = lang;
    }
  }

  @override
  bool updateShouldNotify(covariant LocalizeInherited oldWidget) {
    return oldWidget._currentLocal.lang != _currentLocal.lang;
  }
}

/// Localization support
enum Lang { en, km, zh }
