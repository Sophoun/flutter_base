import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/widgets/loading.dart';

class FlutterBase extends StatelessWidget {
  const FlutterBase({
    super.key,
    required this.child,
    this.viewModels = const [],
    this.localizeList = const [],
    this.lang = Lang.en,
    this.loadingWidget = const Loading(),
    this.diContainer,
  });

  final List<BaseVm> viewModels;
  final List<AppLocalize> localizeList;
  final Lang lang;
  final Widget child;
  final Widget loadingWidget;

  /// DI Container hold all registered dependencies
  /// from the outside.
  /// Note: It's singleton, it's not showing using here but
  /// actualy it's will used by client
  final DiContainer? diContainer;

  @override
  Widget build(BuildContext context) {
    return LocalizeInherited(
      lang: lang,
      localizeList: localizeList,
      child: VmInherited(
        viewModels: viewModels,
        child: Builder(
          builder: (context) {
            final vm = VmInherited.of<BaseVm>(context);

            return Builder(
              builder: (context) => Stack(
                textDirection: TextDirection.rtl,
                children: [
                  // Call the build method of the widget
                  // This allows the widget to define its UI based on the current state
                  child,
                  // Display loading indicator if the ViewModel is loading
                  ValueListenableBuilder(
                    valueListenable: vm.isLoading,
                    builder: (context, value, child) =>
                        Visibility(visible: value, child: loadingWidget),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
