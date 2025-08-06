import 'package:example/lang/app_lang.dart';

class En extends AppLang {
  En({required super.lang});

  @override
  String appName() => "Flutter Base";

  @override
  String count(int count) => "Current counter is: $count";

  @override
  String currentLanguageIs(String lang) => "Current language is: $lang";
}
