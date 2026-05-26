import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/dimensions.dart';

// Breakpoints — single source of truth
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1280;
}

// Screen size enum for easy switching
enum ScreenSize { mobile, tablet, desktop }

// Core utility class
class Responsive {
  final double _width;

  Responsive(BuildContext context) : _width = MediaQuery.sizeOf(context).width;

  /// Use when you only have a width value, not a BuildContext.
  /// e.g. called from NeuTopNavTheme.resolvedHorizontalPadding(screenWidth)
  Responsive.fromWidth(this._width);

  // Screen size classification
  ScreenSize get screenSize {
    if (_width < Breakpoints.mobile) return ScreenSize.mobile;
    if (_width < Breakpoints.tablet) return ScreenSize.tablet;
    return ScreenSize.desktop;
  }

  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;
  bool get isMobileOrTablet => isMobile || isTablet;

  // Horizontal padding (mirrors the logic in NeuTopNavTheme)
  double get horizontalPadding {
    if (_width >= Breakpoints.desktop) {
      return Dimensions.desktopHorizontalPadding;
    }
    if (_width <= Breakpoints.mobile) return 20;
    final t =
        (_width - Breakpoints.mobile) /
        (Breakpoints.desktop - Breakpoints.mobile);
    return 20 + (Dimensions.desktopHorizontalPadding - 20) * t;
  }

  // Section height
  double get sectionHeight {
    if (isMobile) return double.infinity; // let content size itself
    if (isTablet) return 500;
    return 600;
  }

  // Typography scale
  double get displayFontSize => isMobile
      ? 32
      : isTablet
      ? 38
      : 42;
  double get headingFontSize => isMobile
      ? 22
      : isTablet
      ? 28
      : 32;
  double get subtitleFontSize => isMobile
      ? 11
      : isTablet
      ? 12
      : 13;
  double get bodyFontSize => isMobile ? 13 : 14;

  // Avatar size
  double get avatarSize => isMobile
      ? 200
      : isTablet
      ? 280
      : 380;

  // Value helper — pick by screen size
  T value<T>({required T mobile, T? tablet, required T desktop}) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? desktop;
    return desktop;
  }
}

// Drop-in builder widget — use anywhere
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Responsive r) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context, Responsive(context));
  }
}
