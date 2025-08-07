import 'package:flutter/material.dart';
import 'package:flutter_base/src/di/vm_container.dart';

import '../base/base_vm.dart';

/// Lading widget
class Loading extends StatelessWidget {
  Loading({super.key});

  final vm = VmContainer().get<BaseVm>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ValueListenableBuilder(
          valueListenable: isAppLoading,
          builder: (context, value, child) => Visibility(
            visible: value,
            child: Container(
              color: Colors.black38,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
