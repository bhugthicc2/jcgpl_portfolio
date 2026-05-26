import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/data/about_data.dart';
import 'package:jcgpl_portfolio/sections/about/entry/timeline_entry.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/section_heading.dart';

class EducationTimeline extends StatelessWidget {
  final Responsive r;
  const EducationTimeline({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: "Education", r: r),
        const SizedBox(height: 24),
        ...List.generate(AboutData.education.length, (i) {
          final isLast = i == AboutData.education.length - 1;
          return TimelineEntry(entry: AboutData.education[i], isLast: isLast);
        }),
      ],
    );
  }
}
