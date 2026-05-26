import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';

class SectionHeading extends StatelessWidget {
  final String title;
  final Responsive r;

  const SectionHeading({super.key, required this.title, required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: r.headingFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1e2f4d),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        const NeuDivider(),
      ],
    );
  }
}
