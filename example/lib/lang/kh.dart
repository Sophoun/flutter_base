import 'package:example/lang/app_lang.dart';

class Kh extends AppLang {
  Kh({required super.lang});

  @override
  String appName() => "Flutter Base";

  @override
  String count(int count) => "ចំនួនបច្ចុបន្នគឺ: $count";

  @override
  String currentLanguageIs(String lang) => "ភាសាបច្ចុបន្នគឺ: $lang";
}
