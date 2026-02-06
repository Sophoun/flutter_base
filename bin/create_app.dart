#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:yaml_edit/yaml_edit.dart';

void main(List<String> args) {
  try {
    switch (args.firstOrNull) {
      case "--name":
        if (args.length < 2) {
          print(
            red(
              "Missing app name. To create run: dart run sp_kit:create_app --name <your_app_name>",
            ),
          );
          return;
        }
        createApp(args[1]);
        break;
    }
  } catch (e) {
    print(red(e.toString()));
  }
}

/// Create app
void createApp(String? appName) {
  print("creating app $appName");
  "flutter create $appName".run;

  ///
  /// Delete unecessery folders
  ///
  deleteDir("$appName/test");

  ///
  /// Add directories structure
  ///

  /// Assets
  final assetsPath = "$appName/assets";
  if (!exists(assetsPath)) createDir(assetsPath);

  /// Images
  final imagesPath = "$appName/assets/images";
  if (!exists(imagesPath)) createDir(imagesPath, recursive: true);

  /// Add path to yaml assets path
  final file = File('$appName/pubspec.yaml');
  final yamlString = file.readAsStringSync().replaceFirst(
    '# assets:',
    'assets:',
  );
  final yamlEditor = YamlEditor(yamlString);
  yamlEditor.update(['flutter', 'assets'], ['assets/images/']);
  yamlEditor.update(['flutter_gen'], {'output': 'lib/gen/'});
  yamlEditor.update(
    ['flutter_gen', 'integrations'],
    {'image': true, 'flutter_svg': true},
  );
  file.writeAsStringSync(yamlEditor.toString());

  ///
  /// Add folders structure
  ///
  final folders = [
    "lib/features",
    "lib/remote",
    "lib/db",
    "lib/gen",
    "lib/lang",
    "lib/router",
    "lib/view_models",
    "lib/widgets",
    "lib/utils",
  ];

  for (final folder in folders) {
    final path = "$appName/$folder";
    if (!exists(path)) createDir(path, recursive: true);
  }

  ///
  /// Add dependencies
  ///
  /// sp_kit
  "flutter pub add 'sp_kit:{\"git\":{\"url\":\"https://github.com/Sophoun/sp_kit.git\",\"ref\":\"main\"}}'"
      .start(workingDirectory: appName);

  /// dependencies
  final dependencies = [
    "auto_route",
    "google_fonts",
    "flutter_gen",
    "flutter_native_splash",
    "flutter_launcher_icons",
    "dio",
  ];
  for (final dependency in dependencies) {
    "flutter pub add $dependency".start(workingDirectory: appName);
  }

  /// dev dependencies
  final devDependencies = [
    "build_runner",
    "auto_route_generator",
    "flutter_gen_runner",
  ];
  for (final dependency in devDependencies) {
    "flutter pub add $dependency --dev".start(workingDirectory: appName);
  }

  /// Run pub get
  "flutter pub get".start(workingDirectory: appName);

  ///
  /// Create flutter_native_splash.yaml and flutter_launcher_icons.yaml files
  ///

  /// Native splash screen
  touch(
    "$appName/flutter_native_splash.yaml",
    create: true,
  ).write(flutterNativeSplashContent);

  /// Launcher icon
  "dart run flutter_launcher_icons:generate".start(workingDirectory: appName);

  ///
  /// Create watch.sh command
  ///
  touch("$appName/watch.sh", create: true).write("""
#!/bin/bash

# Generate splash screen
dart run flutter_native_splash:create --path=flutter_native_splash.yaml

# Generate launcher icon
dart run flutter_launcher_icons

# Build and watch the changes
dart run build_runner watch --delete-conflicting-outputs
""");

  ///
  /// Create necessery files
  ///

  /// Home ViewModel
  touch(
    "$appName/lib/view_models/home_vm.dart",
    create: true,
  ).write(homeVmContent(appName!));

  /// Home page
  final homeFeaturePath = "$appName/lib/features/home";
  if (!exists(homeFeaturePath)) createDir(homeFeaturePath, recursive: true);
  touch(
    "$appName/lib/features/home/home_page.dart",
    create: true,
  ).write(homePageContent(appName));

  /// Router
  touch(
    "$appName/lib/router/app_router.dart",
    create: true,
  ).write(appRouterContent(appName));

  /// Languages
  touch("$appName/lib/lang/app_lang.dart", create: true).write(appLangContent);
  touch(
    "$appName/lib/lang/lang_en.dart",
    create: true,
  ).write(enLangContent(appName));
  touch(
    "$appName/lib/lang/lang_km.dart",
    create: true,
  ).write(kmLangContent(appName));

  /// API
  touch("$appName/lib/remote/api.dart", create: true).write(apiContent);

  /// Main file
  touch("$appName/lib/main.dart", create: true).write(mainPageConent(appName));

  /// Environment variable
  final envPath = "$appName/env";
  if (!exists(envPath)) createDir(envPath);
  touch("$appName/env/dev.json", create: true).write('{ "ENV": "DEV"  }');
  touch("$appName/env/stag.json", create: true).write('{ "ENV": "STAGING"  }');
  touch("$appName/env/prod.json", create: true).write('{ "ENV": "PROD"  }');
  touch("$appName/lib/env_config.dart", create: true).write(envConfigContent);

  /// VS Code runner
  final vsCodePath = "$appName/.vscode";
  if (!exists(vsCodePath)) createDir(vsCodePath, recursive: true);
  touch(
    "$appName/.vscode/launch.json",
    create: true,
  ).write(vsCodeRunner(appName));

  ///
  /// Run build script
  ///
  'dart run build_runner build --delete-conflicting-outputs'.start(
    workingDirectory: appName,
  );

  ///
  /// Print success
  ///
  print(
    green("""
Your project named: $appName was created successfully.
In order to open your application, type:

  \$ cd $appName
or:
  \$ code $appName

To start your development. :)
"""),
  );
}

///
/// VS Code runner
///
String vsCodeRunner(String appName) =>
    """
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "$appName-dev",
      "request": "launch",
      "type": "dart",
      "args": [
        "-t",
        "./lib/main.dart",
        "--dart-define-from-file",
        "env/dev.json"
      ]
    },
    {
      "name": "$appName-stag",
      "request": "launch",
      "type": "dart",
      "args": [
        "-t",
        "./lib/main.dart",
        "--dart-define-from-file",
        "env/stag.json"
      ]
    },
    {
      "name": "$appName-prod",
      "request": "launch",
      "type": "dart",
      "args": [
        "-t",
        "./lib/main.dart",
        "--dart-define-from-file",
        "env/prod.json"
      ]
    },
    {
      "name": "flutter_base_preview",
      "type": "node-terminal",
      "request": "launch",
      // https://docs.flutter.dev/tools/widget-previewer
      "command": "flutter widget-preview start"
    }
  ]
}
""";

///
/// env_config.dart content
///
final envConfigContent = """
import 'dart:developer';

class EnvConfig {
  static const String _notFound = "NOT_FOUND";

  static const String env = String.fromEnvironment(
    'ENV',
    defaultValue: _notFound,
  );

  static void validate() {
    final missingKeys = <String>[];
    if (env == _notFound) missingKeys.add('ENV');
    if (missingKeys.isNotEmpty) {
      final error = '❌ MISSING ENVIRONMENT VARIABLES: \${missingKeys.join(", ")} Make sure to run with: --dart-define-from-file=env/<env_name>.json';

      assert(() {
        throw Exception(error);
      }());

      log(error);
    }
  }
}

""";

///
/// api.dart
///
final apiContent = """
import 'package:dio/dio.dart';
import 'package:sp_kit/sp_kit.dart';

class Api {
  final _dio = Dio(BaseOptions(baseUrl: String.fromEnvironment('BASE_URL')));

  Future<bool> ping() async {
    final result = await _dio.get("/ping").toEither();
    switch (result) {
      case Right<Response<dynamic>, EitherException>():
        return true;
      case Left<Response<dynamic>, EitherException>():
        return false;
    }
  }
}
""";

///
/// app_lang.dart file content
///
final appLangContent = """
import 'package:sp_kit/sp_kit.dart';

abstract class AppLang extends AppLocalize {
  AppLang({required super.lang});

  String get appName;
}
""";

///
/// en.dart file content
///
String enLangContent(String appName) =>
    """
import 'package:sp_kit/sp_kit.dart';
import 'package:$appName/lang/app_lang.dart';

class LangEn extends AppLang {
  LangEn() : super(lang: Lang.en);

  @override
  String get appName => "$appName";
}
""";

///
/// en.dart file content
///
String kmLangContent(String appName) =>
    """
import 'package:sp_kit/sp_kit.dart';
import 'package:$appName/lang/app_lang.dart';

class LangKm extends AppLang {
  LangKm() : super(lang: Lang.km);
  
  @override
  String get appName => "$appName";
}
""";

///
/// main.dart content
///
String mainPageConent(String appName) =>
    """
import 'package:flutter/material.dart';
import 'package:$appName/env_config.dart';
import 'package:$appName/lang/app_lang.dart';
import 'package:$appName/lang/lang_en.dart';
import 'package:$appName/lang/lang_km.dart';
import 'package:$appName/router/app_router.dart';
import 'package:$appName/view_models/home_vm.dart';
import 'package:$appName/remote/api.dart';
import 'package:sp_kit/sp_kit.dart';

void main(List<String> args) {
  EnvConfig.validate();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final router = AppRouter();
  final serviceLocators = ServiceLocator()
    ..register(HomeVm())
    ..register(Api());

  @override
  Widget build(BuildContext context) {
    return SpKit(
      routerConfig: router.config(),
      serviceLocator: serviceLocators,
      locale: LocaleRegister<AppLang>()
        ..register(LangEn())
        ..register(LangKm())
        ..changeLang(Lang.en),
    );
  }
}
""";

///
/// home_page.dart content
///
String homePageContent(String appName) =>
    """
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:$appName/lang/app_lang.dart';
import 'package:$appName/env_config.dart';
import 'package:sp_kit/sp_kit.dart';
import 'package:$appName/view_models/home_vm.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  HomeVm get homeVm => inject<HomeVm>();

  @override
  Widget build(BuildContext context) {
    final t = context.t<AppLang>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [Text(t.appName), Text(EnvConfig.env)],
        ),
      ),
    );
  }
}
""";

///
/// main_vm.dart content
///
String homeVmContent(String appName) =>
    """
import 'package:flutter/widgets.dart';
import 'package:$appName/remote/api.dart';
import 'package:sp_kit/sp_kit.dart';

class HomeVm extends ChangeNotifier {
  Api get api => inject<Api>();
}
""";

///
/// app_router.dart content
///
String appRouterContent(String appName) =>
    """
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:$appName/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
  ];

  /// A custom modal sheet route builder that creates a modal bottom sheet
  Route<T> modalSheetBuilder<T>(
    BuildContext context,
    Widget child,
    Page<T> page,
  ) {
    return ModalBottomSheetRoute(
      settings: page,
      builder: (context) => SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 600, minHeight: 100),
            child: child,
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Route<T> modalDialogBuilder<T>(
    BuildContext context,
    Widget child,
    Page<T> page,
  ) {
    return DialogRoute(
      settings: page,
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(child: child),
    );
  }
}

""";

///
/// Flutter native splash content
///
final flutterNativeSplashContent = """
flutter_native_splash:
  # This package generates native code to customize Flutter's default white native splash screen
  # with background color and splash image.
  # Steps to make this work:
  # 1. Customize the parameters below.
  # 2. run the following command in the terminal:
  # dart run flutter_native_splash:create
  # or if you place this not in pubspec.yaml and not in flutter_native_splash.yaml:
  # dart run flutter_native_splash:create -p ../your-filepath.yaml
  # 3. voila, done!

  # NOTES:
  # - in case you got some trouble, cleaning up flutter project might help:
  # flutter clean ; flutter pub get
  # - To restore Flutter's default white splash screen, run the following command in the terminal:
  # dart run flutter_native_splash:remove
  # or if you place this not in pubspec.yaml and not in flutter_native_splash.yaml:
  # dart run flutter_native_splash:remove -p ../your-filepath.yaml

  # IMPORTANT NOTE: These parameter do not affect the configuration of Android 12 and later, which
  # handle splash screens differently that prior versions of Android.  Android 12 and later must be
  # configured specifically in the android_12 section below, at the very end.

  #======================================================================
  
  # uncomment this if you want to disable this package for specific platform:
  # android: false
  # ios: false
  # web: false
  
  #======================================================================

  #! FOR ALL PLATFORM, except Android 12+:

  # general color for all platform (except android 12+):
  # see there only 2 lines in all parameters that marked as [required], so others
  # remain optional. NOTE that if you specify the [required] color, then you cant 
  # use the [required] background_image in the next section. the reverse is true.
  # select one, they cant work together.
  color: "#42a5f5"  ##====================================[REQUIRED]==========
  #color_dark: "#042a49"
  # platform-specific color. will override general color if active:
  #color_android: "#42a5f5"
  #color_dark_android: "#042a49"
  #color_ios: "#42a5f5"
  #color_dark_ios: "#042a49"
  #color_web: "#42a5f5"
  #color_dark_web: "#042a49"

  # general background_image for all platform (except android 12+)
  # if you specify this [required] background_image, then you should comment the 
  # [required] color in previous section. select one, they cant work together.
  #background_image:      "assets/background.png" #========[REQUIRED]============
  #background_image_dark: "assets/dark-background.png"
  # platform-specific background_image. will override general background_image if active:
  #background_image_android:      "assets/background-android.png"
  #background_image_dark_android: "assets/dark-background-android.png"
  #background_image_ios:          "assets/background-ios.png"
  #background_image_dark_ios:     "assets/dark-background-ios.png"
  #background_image_web:          "assets/background-web.png"
  #background_image_dark_web:     "assets/dark-background-web.png"

  # general image for all platform (except android 12+):
  # allows you to specify an image used in the splash screen. It must be a
  # png file and should be sized for 4x pixel density.
  image:                assets/splash.png
  #image_dark:          assets/splash-invert.png
  # platform-specific image. will override general image if active:
  #image_android:       assets/splash-android.png
  #image_dark_android:  assets/splash-invert-android.png
  #image_ios:           assets/splash-ios.png
  #image_dark_ios:      assets/splash-invert-ios.png
  #image_web:           assets/splash-web.gif
  #image_dark_web:      assets/splash-invert-web.gif  

  # image alignment (default center if not specified, or speccified something else):
  #android_gravity: center       # bottom, center, center_horizontal, center_vertical, 
  # clip_horizontal, clip_vertical, end, fill, fill_horizontal, fill_vertical, left, right, start, top. could also be a combination like `android_gravity: fill|clip_vertical`
  # This will fill the width while maintaining the image's vertical aspect ratio.
  # visit https://developer.android.com/reference/android/view/Gravity
  #ios_content_mode: center      # scaleToFill, scaleAspectFit, scaleAspectFill, 
  # center, top, bottom, left, right, topLeft, topRight, bottomLeft, or bottomRight.
  # visit https://developer.apple.com/documentation/uikit/uiview/contentmode
  #web_image_mode: center        # center, contain, stretch, cover

  # general branding for all platform (except android 12+):
  # allows you to specify an image used as branding in the splash screen. should be png.
  #branding:      assets/dart.png
  #branding_dark: assets/dart_dark.png
  # platform-specific branding. will override general branding if active:
  #branding_android:      assets/brand-android.png
  #branding_dark_android: assets/dart_dark-android.png
  #branding_ios:          assets/brand-ios.png
  #branding_dark_ios:     assets/dart_dark-ios.png
  #branding_web:          assets/brand-web.gif
  #branding_dark_web:     assets/dart_dark-web.gif

  # branding position:
  # you can use bottom, bottomRight, and bottomLeft. The default values is 
  # bottom if not specified or specified something else.
  #branding_mode: bottom                # default bottom
  #branding_bottom_padding: 24          # default 0
  #branding_bottom_padding_android: 24  # default 0
  #branding_bottom_padding_ios: 24      # default 0
  # branding bottom padding web is not available yet.

  # The screen orientation can be set in Android with the android_screen_orientation parameter.
  # Valid parameters can be found here:
  # https://developer.android.com/guide/topics/manifest/activity-element#screen
  #android_screen_orientation: sensorLandscape

  # hide notif bar on android. ios already hides it by default. 
  # Has no effect in web since web has no notification bar.
  fullscreen: true                # default false
  # if you dont want to hide notif bar, for android just set this to false,
  # but for ios, add this to your flutter main():
  # WidgetsFlutterBinding.ensureInitialized(); 
  # SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top], );
    
  #! extra note for IOS:
  # If you have changed the name(s) of your info.plist file(s), you can specify the filename(s)
  # with the info_plist_files parameter.  Remove only the # characters in the three lines below,
  # do not remove any spaces:
  #info_plist_files:
  #  - 'ios/Runner/Info-Debug.plist'
  #  - 'ios/Runner/Info-Release.plist'

  #========================================================================

  # what we did above won't affect Android 12 and newer at all. they have different
  # handling concept. visit https://developer.android.com/guide/topics/ui/splash-screen
  
  #! ANDROID 12+ configuration:
  android_12:
    # background color
    color: "#42a5f5"
    # color_dark: "#042a49"

    # center-logo
    # If this parameter is not specified, the app's launcher icon will be used instead. 
    # Please note that the splash screen will be clipped to a circle on the center of the screen. 
    # with background: 960×960 px (fit within circle 640px in diameter)    
    # without background: 1152×1152 px (fit within circle 768px in diameter)
    # ensure that the most important design elements of your image are placed within a circular area 
    image: assets/images/logo/blank.png    
    # image_dark: assets/images/logo/logo-splash2.png  

    # center-logo background color
    icon_background_color: "#111111"
    # icon_background_color_dark: "#eeeeee"

    # branding:
    # The branding image dimensions must be 800x320 px.
    #branding:      assets/dart.png      
    #branding_dark: assets/dart_dark.png
""";
