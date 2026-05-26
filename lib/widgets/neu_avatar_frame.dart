import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

class NeuAvatarFrame extends StatelessWidget {
  final Widget child;
  final double size;

  const NeuAvatarFrame({super.key, required this.child, this.size = 300});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.base,
        boxShadow: theme.raisedShadows,
      ),
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.base,
          boxShadow: theme.insetShadows,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
