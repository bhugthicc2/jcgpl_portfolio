import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/sections/about/models/personal.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class DetailCard extends StatelessWidget {
  final PersonalDetail detail;
  const DetailCard({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(12),
        //boxShadow: theme.raisedShadows,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: theme.base,
              borderRadius: BorderRadius.circular(10),
              boxShadow: theme.insetShadows,
            ),
            child: Icon(detail.icon, size: 18, color: theme.accent),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.foreground.withValues(alpha: 0.5),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail.value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.foreground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
