import 'package:flutter/material.dart';

/// ResponsiveLayout provide a utility weidget that can
/// support small medium and large screen as wish.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200 && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= 600 && tablet != null) {
          return Align(alignment: Alignment.topCenter, child: tablet);
        } else {
          return Align(alignment: Alignment.topCenter, child: mobile);
        }
      },
    );
  }
}
