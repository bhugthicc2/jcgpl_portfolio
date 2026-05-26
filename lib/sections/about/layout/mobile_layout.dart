import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/content/about_content.dart';
import 'package:jcgpl_portfolio/sections/about/content/education_timeline.dart';

class MobileLayout extends StatelessWidget {
  final Responsive r;
  const MobileLayout({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AboutContent(r: r),
        const SizedBox(height: 48),
        EducationTimeline(r: r),
      ],
    );
  }
}
