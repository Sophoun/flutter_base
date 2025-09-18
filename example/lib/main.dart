import 'package:example/lang/app_lang.dart';
import 'package:example/lang/en.dart';
import 'package:example/lang/kh.dart';
import 'package:example/route/app_router.dart';
import 'package:example/service/mock_net.dart';
import 'package:example/service/mock_service.dart';
import 'package:example/vm/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();
  final diContainer = ServiceLocator()
    ..register(MockNet())
    ..registerLazy((c) => MockService(mockNet: c.get<MockNet>()))
    ..register(HomeVm());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterBase(
      locale: LocaleRegister<AppLang>()
        ..register(En(lang: Lang.en))
        ..register(Kh(lang: Lang.km))
        ..changeLang(Lang.km),
      serviceLocator: diContainer,
      routerConfig: appRouter.config(),
      themeMode: ThemeMode.dark,
      messageDialogWidget: DialgOverride(),
    );
  }
}

// ignore: must_be_immutable
class DialgOverride extends MessageDialog {
  DialgOverride({super.key});

  @override
  // TODO: implement alpha
  int get alpha => 200;

  @override
  Widget buttonOk(BuildContext context) {
    return Expanded(
      child: ElevatedButton(onPressed: onOk, child: Text("IM OK")),
    );
  }

  @override
  Widget buttonCancel(BuildContext context) {
    return Expanded(
      child: ElevatedButton(onPressed: onOk, child: Text("Cancel")),
    );
  }
}
