import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/sections/about/models/stat.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class StatCard extends StatelessWidget {
  final StatItem stat;
  const StatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(16),
        boxShadow: theme.raisedShadows,
      ),
      child: Column(
        children: [
          Text(
            stat.count,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: theme.accent,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: theme.foreground.withValues(alpha: 0.55),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
