import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/data/about_data.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/detail_card.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/section_heading.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/stat_card.dart';

class AboutContent extends StatelessWidget {
  final Responsive r;
  const AboutContent({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: "About Me", r: r),
        const SizedBox(height: 20),
        Text(
          "I'm a Computer Science student with a passion for building clean, "
          "cross-platform applications using Flutter and Firebase. I enjoy turning "
          "complex problems into simple, elegant solutions — whether it's a mobile "
          "app, a web interface, or a backend system.",
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        // Personal details cards
        ...AboutData.details.map((d) => DetailCard(detail: d)),
        const SizedBox(height: 32),
        // Stat counters row
        Row(
          children: AboutData.stats
              .map((s) => Expanded(child: StatCard(stat: s)))
              .toList(),
        ),
      ],
    );
  }
}
