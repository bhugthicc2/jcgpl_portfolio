import 'package:flutter/material.dart';
import 'neu_top_nav_theme.dart';

class NavHamburger extends StatefulWidget {
  final bool open;
  final NeuTopNavTheme theme;
  final VoidCallback onTap;

  const NavHamburger({
    super.key,
    required this.open,
    required this.theme,
    required this.onTap,
  });

  @override
  State<NavHamburger> createState() => _NavHamburgerState();
}

class _NavHamburgerState extends State<NavHamburger> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: widget.theme.base,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _pressed || widget.open
                ? widget.theme.insetShadows
                : widget.theme.raisedShadows,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              widget.open ? Icons.close_rounded : Icons.menu_rounded,
              key: ValueKey(widget.open),
              color: widget.open
                  ? widget.theme.accent
                  : widget.theme.foreground,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
