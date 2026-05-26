import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

// Neumorphic accent divider

class NeuDivider extends StatelessWidget {
  const NeuDivider({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      width: 48,
      height: 3,
      decoration: BoxDecoration(
        color: theme.accent,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: theme.darkShadow,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: theme.lightShadow,
            blurRadius: 4,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
    );
  }
}
