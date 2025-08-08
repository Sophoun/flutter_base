abstract class AppLocalize {
  final Lang lang;

  AppLocalize({required this.lang});
}

class DefaultLocale extends AppLocalize {
  DefaultLocale() : super(lang: Lang.en);
}

/// Localization support
enum Lang { en, km, zh }
