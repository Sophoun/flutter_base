import 'package:flutter/material.dart';

import '../base/base_vm.dart';
import '../inherited/vm_inherited.dart';

/// Lading widget
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final vm = VmInherited.of<BaseVm>(context);
        return ValueListenableBuilder(
          valueListenable: vm.isLoading,
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
