import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class NeuIconButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const NeuIconButton({
    super.key,
    required this.onTap,
    this.icon = Icons.close_rounded,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  State<NeuIconButton> createState() => NeuIconButtonState();
}

class NeuIconButtonState extends State<NeuIconButton> {
  bool _pressed = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    final isActive = _hovered || _pressed;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ??
                (_pressed
                    ? theme.foreground.withValues(alpha: 0.65)
                    : isActive
                    ? theme.foreground.withValues(alpha: 0.55)
                    : theme.foreground.withValues(alpha: 0.45)),
            borderRadius: BorderRadius.circular(999),
            boxShadow: _pressed
                ? theme.insetShadows
                : isActive
                ? theme.raisedShadows
                : [],
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: widget.iconColor ?? theme.base,
          ),
        ),
      ),
    );
  }
}
