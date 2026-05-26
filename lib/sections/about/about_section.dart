import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/layout/desktop_layout.dart';
import 'package:jcgpl_portfolio/sections/about/layout/mobile_layout.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.horizontalPadding,
          vertical: 10,
        ),
        child: r.isMobile ? MobileLayout(r: r) : DesktopLayout(r: r),
      ),
    );
  }
}
