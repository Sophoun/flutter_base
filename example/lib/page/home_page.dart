import 'package:auto_route/auto_route.dart';
import 'package:example/lang/app_lang.dart';
import 'package:example/vm/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

@RoutePage()
class HomePage extends BaseWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, state) {
    final homeVM = state.getVm<HomeVm>();
    final l = state.local.l as AppLang;

    return Scaffold(
      appBar: AppBar(title: Text(l.appName())),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            // Text(l.appName()),
            ElevatedButton(
              onPressed: () {
                homeVM.tryShowLoading();
              },
              child: Text("Loading"),
            ),
            Text(l.currentLanguageIs(l.lang.name)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => state.local.changeLang(Lang.en),
                  child: Text("English"),
                ),
                OutlinedButton(
                  onPressed: () => state.local.changeLang(Lang.km),
                  child: Text("Khmer"),
                ),
              ],
            ),
            homeVM.counter.builder(build: (value) => Text(l.count(value ?? 0))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => homeVM.incrementCounter(),
                  child: Text("increment"),
                ),
                OutlinedButton(
                  onPressed: () => homeVM.decrementCounter(),
                  child: Text("decrement"),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: BaseTextFormField(
                value: homeVM.counter,
                onChanged: (value) {
                  homeVM.counter.value = value!;
                },
                converter: Converter(
                  fromValue: (value) => value.toString(),
                  toValue: (value) => int.tryParse(value ?? "0") ?? 0,
                ),
                label: "Counter",
                hint: "Input any number you wish.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
