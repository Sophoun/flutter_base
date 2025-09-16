import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

/// Loading widget
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

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
