import 'package:sp_kit/sp_kit.dart';

abstract class AppLang extends AppLocalize {
  AppLang({required super.lang});

  String appName();
  String currentLanguageIs(String lang);
  String count(int count);
}
