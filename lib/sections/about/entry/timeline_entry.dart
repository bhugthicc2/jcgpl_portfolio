import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jcgpl_portfolio/sections/about/models/education.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class TimelineEntry extends StatelessWidget {
  final EducationEntry entry;
  final bool isLast;

  const TimelineEntry({super.key, required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    final style = GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: theme.accent,
      letterSpacing: 0.8,
    );
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline spine: dot + line
          SizedBox(
            width: 32,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.base,
                    boxShadow: theme.insetShadows,
                  ),
                  child: Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.accent,
                      ),
                    ),
                  ),
                ),
                // Connecting line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.darkShadow.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Card
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.base,
                borderRadius: BorderRadius.circular(16),
                //boxShadow: theme.raisedShadows,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //logo
                  if (entry.logoPath != null) ...[
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: theme.base,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: theme.insetShadows,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          entry.logoPath!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Period badge
                        Text(entry.period, style: style),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            entry.degree,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1e2f4d),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            entry.school,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF6C8EBF),
                            ),
                          ),
                        ),
                        if (entry.description != null) ...[
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              entry.description!,
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color(
                                  0xFF4a5e7a,
                                ).withValues(alpha: 0.8),
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
