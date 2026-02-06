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

  /// Check if the first latter is capital
  bool get isCapitalFirst {
    if (this == null) return false;
    return this![0].toUpperCase() == this![0];
  }

  /// Check if the each words first latter is capital
  bool get isCapitalEach {
    if (this == null) return false;
    final words = this!.split(' ');
    for (final word in words) {
      if (word.isNotEmpty && !word.isCapitalFirst) return false;
    }
    return true;
  }

  /// Check if it's contain space
  bool get isContainSpace {
    if (this == null) return false;
    return this!.contains(' ');
  }

  /// To capital first latter
  String get toCapitalFirst {
    if (this == null) return '';
    return this![0].toUpperCase() + this!.substring(1);
  }

  /// To capital each words
  String get toCapitalEach {
    if (this == null) return '';
    final words = this!.split(' ');
    for (var i = 0; i < words.length; i++) {
      words[i] = words[i].toCapitalFirst;
    }
    return words.join(' ');
  }
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
