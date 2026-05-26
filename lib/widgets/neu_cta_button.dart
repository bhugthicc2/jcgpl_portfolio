import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class NeuCtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final NeuTopNavTheme theme;

  const NeuCtaButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  State<NeuCtaButton> createState() => _NeuCtaButtonState();
}

class _NeuCtaButtonState extends State<NeuCtaButton> {
  bool _pressed = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: t.base,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _pressed || _hovered ? t.insetShadows : t.raisedShadows,
            border: Border.all(
              color: t.accent.withValues(alpha: _hovered ? 0.45 : 0.0),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: t.linkStyle.copyWith(
                  color: _hovered || _pressed ? t.accent : t.foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                margin: const EdgeInsets.only(top: 3),
                height: 2,
                width: _hovered || _pressed ? 20.0 : 0.0,
                decoration: BoxDecoration(
                  color: t.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
