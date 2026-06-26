import 'package:flutter/widgets.dart';

enum WindowSizeClass { mobile, tablet, desktop }

class Breakpoints {
  static const double mobileMax = 767;
  static const double tabletMin = 768;
  static const double desktopMin = 1200;

  static WindowSizeClass of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final shortestSide = size.shortestSide;
    if (shortestSide < 600) return WindowSizeClass.mobile;
    if (width < tabletMin) return WindowSizeClass.mobile;
    if (width < desktopMin) return WindowSizeClass.tablet;
    return WindowSizeClass.desktop;
  }

  static bool isMobile(BuildContext context) =>
      of(context) == WindowSizeClass.mobile;
  static bool isTablet(BuildContext context) =>
      of(context) == WindowSizeClass.tablet;
  static bool isDesktop(BuildContext context) =>
      of(context) == WindowSizeClass.desktop;
}
