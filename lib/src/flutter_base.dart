import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/localization/localize_inherited.dart';
import 'package:flutter_base/src/widgets/loading.dart';

// ignore: must_be_immutable
class FlutterBase extends StatelessWidget {
  FlutterBase({
    super.key,
    required this.child,
    this.locale,
    this.loadingWidget = const Loading(),
    this.diContainer,
    this.vmContainer,
    this.messageDialogWidget,
    this.designSize = const Size(360, 690),
  }) {
    /// Ensure widget is ready
    WidgetsFlutterBinding.ensureInitialized();

    /// Register locale
    locale ??= LocaleRegister()
      ..register(DefaultLocale())
      ..changeLang(Lang.en);

    /// Initialize share preferences
    Pref.init();
  }

  late LocaleRegister? locale;
  final Widget child;
  final Widget loadingWidget;
  final MessageDialog? messageDialogWidget;
  final Size designSize;

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          // Initialize ScreenUtil here. The Builder provides a context that is a
          // descendant of MaterialApp, so this will be re-run on resize.
          ScreenUtil.init(context, designSize: designSize);

          return LocalizeInherited(
            register: locale!,
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                child,
                StreamBuilder(
                  stream: messageDialog.stream,
                  builder: (context, value) {
                    final message = messageDialogWidget ?? MessageDialog();
                    message.setData(value.data?.value);
                    return Visibility(
                      visible: value.data?.key == true,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: message,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isAppLoading,
                  builder: (context, value, child) {
                    return Visibility(visible: value, child: loadingWidget);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
