import 'package:flutter/material.dart';

/// A utility class for screen-related calculations.
/// This class is initialized in the [FlutterBase] widget.
class ScreenUtil {
  static late double screenWidth;
  static late double screenHeight;
  static late double _scaleWidth;
  static late double _scaleHeight;

  /// Initialize the screen utility.
  /// [context] is the BuildContext from the root widget.
  /// [designSize] is the size of the design screen.
  static void init(
    BuildContext context, {
    Size designSize = const Size(360, 690),
  }) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    _scaleWidth = screenWidth / designSize.width;
    _scaleHeight = screenHeight / designSize.height;
  }
}

/// Extension for scaling numbers to the screen size.
extension ScreenExtension on num {
  /// Scales the number based on the screen width.
  /// Use this for widths, and for heights when you want to maintain aspect ratio.
  double get w => this * ScreenUtil._scaleWidth;

  /// Scales the number based on the screen height.
  /// Use this only when you want a widget's height to be a specific
  /// percentage of the screen's height, not proportional to its own width.
  double get h => this * ScreenUtil._scaleHeight;

  /// Scales the number based on the screen width.
  /// Use this for font sizes.
  double get sp => this * ScreenUtil._scaleWidth;
}
