import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/widgets/loading.dart';

/// FlutterBase'
// ignore: must_be_immutable
class FlutterBase extends StatelessWidget {
  FlutterBase({
    super.key,
    required this.child,
    this.localizeList = const [],
    this.lang = Lang.en,
    this.loadingWidget = const Loading(),
    this.diContainer,
    this.vmContainer,
  });

  final List<AppLocalize> localizeList;
  final Lang lang;
  final Widget child;
  final Widget loadingWidget;

  /// DI Container hold all registered dependencies
  /// from the outside.
  /// Note: It's singleton, it's not showing using here but
  /// actualy it's will used by client
  final DiContainer? diContainer;

  /// ViewModel Container hold all registered dependencies
  /// from the outside.
  /// Note: It's singleton, it's not showing using here but
  /// actualy it's will used by client
  late VmContainer? vmContainer;

  @override
  Widget build(BuildContext context) {
    return LocalizeInherited(
      lang: lang,
      localizeList: localizeList,
      child: Stack(
        textDirection: TextDirection.rtl,
        children: [
          // Call the build method of the widget
          // This allows the widget to define its UI based on the current state
          child,
          // Display loading indicator if the ViewModel is loading
          ValueListenableBuilder(
            valueListenable: isAppLoading,
            builder: (context, value, child) =>
                Visibility(visible: value, child: loadingWidget),
          ),
        ],
      ),
    );
  }
}
