import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_base/src/localization/localize_inherited.dart';
import 'package:flutter_base/src/widgets/loading_indicator.dart';

// ignore: must_be_immutable
class FlutterBase extends StatelessWidget {
  FlutterBase({
    super.key,
    this.locale,
    this.loadingWidget = const LoadingIndicator(),
    this.serviceLocator,
    this.routerConfig,
    this.routeInformationParser,
    this.routeInformationProvider,
    this.routerDelegate,
    this.messageDialogWidget,
    this.designSize = const Size(360, 690),
    this.screenSize,
    this.theme,
    this.darkTheme,
    this.themeMode,
  }) {
    /// Assign theme if it's missing
    theme ??= BaseTheme.light;
    darkTheme ??= BaseTheme.dark;
    themeMode ??= ThemeMode.system;

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
  final Widget loadingWidget;
  final MessageDialog? messageDialogWidget;
  final Size designSize;
  final Size? screenSize;

  /// A Service Locator that hold all registered dependencies
  /// from the outside.
  /// Note: It's singleton, it's not showing using here but
  /// actualy it's will used by client
  final ServiceLocator? serviceLocator;

  final RouterConfig<Object>? routerConfig;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouteInformationProvider? routeInformationProvider;
  final RouterDelegate<Object>? routerDelegate;
  late ThemeData? theme;
  late ThemeData? darkTheme;
  late ThemeMode? themeMode;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: designSize, screenSize: screenSize);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: routerConfig,
      routeInformationParser: routeInformationParser,
      routeInformationProvider: routeInformationProvider,
      routerDelegate: routerDelegate,
      builder: (context, child) => LocalizeInherited(
        register: locale!,
        child: Stack(
          textDirection: TextDirection.rtl,
          children: [
            child ?? SizedBox.shrink(),
            StreamBuilder(
              stream: messageDialog.stream,
              builder: (context, value) {
                final message = messageDialogWidget ?? MessageDialog();
                message.setData(value.data?.value);
                return Visibility(
                  key: UniqueKey(),
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
      ),
    );
  }
}
