import 'package:auto_route/auto_route.dart';
import 'package:example/lang/app_lang.dart';
import 'package:example/vm/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/flutter_base.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  HomeVm get homeVm => vm.get<HomeVm>();

  @override
  Widget build(BuildContext context) {
    final t = context.t<AppLang>();

    return Scaffold(
      appBar: AppBar(title: Text(t.appName())),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            // Text(l.appName()),
            ElevatedButton(
              onPressed: () {
                homeVm.tryShowLoading();
              },
              child: Text("Loading"),
            ),
            Text(t.currentLanguageIs(t.lang.name)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => context.local.register.changeLang(Lang.en),
                  child: Text("English"),
                ),
                OutlinedButton(
                  onPressed: () => context.local.register.changeLang(Lang.km),
                  child: Text("Khmer"),
                ),
              ],
            ),
            homeVm.counter.builder(build: (value) => Text(t.count(value ?? 0))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () => homeVm.incrementCounter(),
                  child: Text("increment"),
                ),
                OutlinedButton(
                  onPressed: () => homeVm.decrementCounter(),
                  child: Text("decrement"),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: BaseTextFormField(
                value: homeVm.counter,
                converter: Converter(
                  fromValue: (value) => value.toString(),
                  toValue: (value) => int.tryParse(value ?? "0") ?? 0,
                ),
                label: "Counter",
                hint: "Input any number you wish.",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                helperText: "Only number allowed.",
                autofocus: true,
              ),
            ),
            homeVm.mockValue.builder(build: (value) => Text(value ?? "")),
            ElevatedButton(
              onPressed: () => homeVm.getMockData(),
              child: Text("Get Mock Data"),
            ),
          ],
        ),
      ),
    );
  }
}
