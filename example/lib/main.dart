import 'package:example/lang/en.dart';
import 'package:example/lang/kh.dart';
import 'package:example/route/app_router.dart';
import 'package:example/vm/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterBase(
      lang: Lang.km,
      localizeList: [
        En(lang: Lang.en),
        Kh(lang: Lang.km),
      ],
      viewModels: [HomeVm()],
      child: MaterialApp.router(routerConfig: appRouter.config()),
    );
  }
}
