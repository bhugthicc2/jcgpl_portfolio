import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

class AvailabilityBadge extends StatelessWidget {
  const AvailabilityBadge({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(999),
        boxShadow: theme.raisedShadows,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.greenAccent.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Available for work",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.accent,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
