import 'package:flutter_base/flutter_base.dart';

abstract class AppLang extends AppLocalize {
  AppLang({required super.lang});

  String appName();
  String currentLanguageIs(String lang);
  String count(int count);
}
