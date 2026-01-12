import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringExtension on String? {
  /// Return null or value but not empty
  String? get orNull {
    if (this == null || this!.isEmpty) return null;
    return this;
  }

  /// Return empty or value but not null
  String get orEmpty => this ?? '';

  /// Check value is null or empty
  bool get isNullOrEmpty {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    return false;
  }

  /// Check value is not empty
  bool get isNotEmpty {
    return this != null && this!.length > 1;
  }

  /// Return default string or value but not null
  String orDefault(String value) => this ?? value;
}

/// SVG File path to Image object
extension StringExtendToSvg on String? {
  Widget toImage({
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    Widget Function(BuildContext)? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    Widget Function(BuildContext, Object, StackTrace)? errorBuilder,
    SvgTheme? theme,
    ColorMapper? colorMapper,
  }) {
    return SvgPicture.asset(
      this!,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      errorBuilder: errorBuilder,
      theme: theme,
      colorMapper: colorMapper,
    );
  }
}
