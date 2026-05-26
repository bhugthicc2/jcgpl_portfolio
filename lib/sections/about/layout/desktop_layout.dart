import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/content/about_content.dart';
import 'package:jcgpl_portfolio/sections/about/content/education_timeline.dart';

class DesktopLayout extends StatelessWidget {
  final Responsive r;
  const DesktopLayout({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: education timeline
        Expanded(flex: 5, child: EducationTimeline(r: r)),
        const SizedBox(width: 48),
        // Right: bio + details + stats
        Expanded(flex: 4, child: AboutContent(r: r)),
      ],
    );
  }
}
