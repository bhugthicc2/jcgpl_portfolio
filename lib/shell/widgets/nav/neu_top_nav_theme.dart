import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';

class NeuTopNavTheme {
  final Color base;
  final Color lightShadow;
  final Color darkShadow;
  final Color foreground;
  final Color accent;
  final double height;
  final double blurRadius;
  final double shadowOffset;
  final TextStyle linkStyle;
  final TextStyle dropdownLinkStyle;

  const NeuTopNavTheme({
    this.base = const Color(0xFFE0E5EC),
    this.lightShadow = const Color(0xFFFFFFFF),
    this.darkShadow = const Color(0xFFA3B1C6),
    this.foreground = const Color(0xFF31456A),
    this.accent = const Color(0xFF6C8EBF),
    this.height = 68,
    this.blurRadius = 18,
    this.shadowOffset = 6,
    this.linkStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    this.dropdownLinkStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    ),
  });

  double resolvedHorizontalPadding(double screenWidth) =>
      Responsive.fromWidth(screenWidth).horizontalPadding;

  List<BoxShadow> get raisedShadows => [
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius,
      offset: Offset(-shadowOffset, -shadowOffset),
    ),
    BoxShadow(
      color: darkShadow,
      blurRadius: blurRadius,
      offset: Offset(shadowOffset, shadowOffset),
    ),
  ];

  List<BoxShadow> get insetShadows => [
    BoxShadow(
      color: darkShadow,
      blurRadius: blurRadius * 0.6,
      offset: Offset(shadowOffset * 0.6, shadowOffset * 0.6),
    ),
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius * 0.6,
      offset: Offset(-shadowOffset * 0.6, -shadowOffset * 0.6),
    ),
  ];

  List<BoxShadow> get hoverShadows => [
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius * 1.1,
      offset: Offset(-shadowOffset * 0.8, -shadowOffset * 0.8),
    ),
    BoxShadow(
      color: darkShadow.withValues(alpha: 0.6),
      blurRadius: blurRadius * 1.1,
      offset: Offset(shadowOffset * 0.8, shadowOffset * 0.8),
    ),
  ];

  static const NeuTopNavTheme dark = NeuTopNavTheme(
    base: Color(0xFF2D2D3A),
    lightShadow: Color(0xFF3D3D4E),
    darkShadow: Color(0xFF1A1A24),
    foreground: Color(0xFFD0D8EE),
    accent: Color(0xFF7B9FD4),
  );
}
