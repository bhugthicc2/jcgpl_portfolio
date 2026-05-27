import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/about/data/about_data.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/detail_card.dart';
import 'package:jcgpl_portfolio/sections/about/widgets/section_heading.dart';

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
        _BioText(r: r),
        const SizedBox(height: 32),
        ...AboutData.details.map((d) => DetailCard(detail: d)),
      ],
    );
  }
}

class _BioText extends StatelessWidget {
  final Responsive r;
  const _BioText({required this.r});

  @override
  Widget build(BuildContext context) {
    // RichText doesn't inherit ThemeData.textTheme so we set Poppins explicitly
    final style = GoogleFonts.poppins(
      fontSize: r.bodyFontSize,
      color: const Color(0xFF4a5e7a),
      height: 1.8,
    );

    final highlight = GoogleFonts.poppins(
      fontSize: r.bodyFontSize,
      color: const Color(0xFF31456A),
      fontWeight: FontWeight.w600,
      height: 1.8,
    );

    return RichText(
      text: TextSpan(
        style: style,
        children: [
          const TextSpan(text: "I'm a "),
          TextSpan(text: "Computer Science student", style: highlight),
          const TextSpan(text: " specializing in "),
          TextSpan(
            text: "Flutter cross-platform development",
            style: highlight,
          ),
          const TextSpan(text: " and "),
          TextSpan(text: "Firebase backend integration", style: highlight),
          const TextSpan(
            text:
                ".\n\n"
                "I build production-ready mobile and web applications from "
                "real-time ",
          ),
          TextSpan(text: "QR-based systems", style: highlight),
          const TextSpan(text: " and "),
          TextSpan(text: "AES-encrypted data pipelines", style: highlight),
          const TextSpan(
            text:
                " to full UI/UX implementation with "
                "neumorphic design systems.\n\n"
                "Currently looking for opportunities in ",
          ),
          TextSpan(
            text:
                "mobile development, system development, "
                "or UI-focused engineering roles",
            style: highlight,
          ),
          const TextSpan(
            text: " where I can ship real products and grow with a team.",
          ),
        ],
      ),
    );
  }
}
