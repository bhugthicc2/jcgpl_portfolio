import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'nav_dropdown.dart';
import 'nav_helpers.dart';
import 'neu_top_nav_theme.dart';

class NavItemDesktop extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;

  const NavItemDesktop({
    super.key,
    required this.item,
    required this.theme,
    required this.activeLabel,
    required this.onNavigate,
  });

  @override
  State<NavItemDesktop> createState() => _NavItemDesktopState();
}

class _NavItemDesktopState extends State<NavItemDesktop>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  OverlayEntry? _overlay;
  final LayerLink _link = LayerLink();

  NeuTopNavTheme get t => widget.theme;
  bool get hasChildren => widget.item.children.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _closeDropdown();
    _ctrl.dispose();
    super.dispose();
  }

  void _openDropdown() {
    _overlay = OverlayEntry(
      builder: (_) => NavDropdownOverlay(
        link: _link,
        items: widget.item.children,
        theme: t,
        activeLabel: widget.activeLabel,
        animation: _fade,
        slideAnimation: _slide,
        onNavigate: widget.onNavigate,
        onDismiss: _closeDropdown,
      ),
    );
    Overlay.of(context).insert(_overlay!);
    _ctrl.forward();
  }

  void _closeDropdown() {
    _ctrl.reverse().then((_) {
      _overlay?.remove();
      _overlay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isActive = isNavItemActive(widget.item, widget.activeLabel);
    final highlighted = isTabHighlighted(
      isActive: isActive,
      hovered: _hovered,
      pressed: _pressed,
    );

    return CompositedTransformTarget(
      link: _link,
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _hovered = true);
          if (hasChildren && _overlay == null) _openDropdown();
        },
        onExit: (_) {
          setState(() {
            _hovered = false;
            _pressed = false;
          });
          if (hasChildren) _closeDropdown();
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: hasChildren
              ? null
              : (_) => setState(() => _pressed = true),
          onTapUp: hasChildren ? null : (_) => setState(() => _pressed = false),
          onTapCancel: hasChildren
              ? null
              : () => setState(() => _pressed = false),
          onTap: hasChildren ? null : () => widget.onNavigate(widget.item),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: t.base,
              borderRadius: BorderRadius.circular(12),
              boxShadow: highlighted ? t.insetShadows : [],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.item.label,
                      style: t.linkStyle.copyWith(
                        color: highlighted ? t.accent : t.foreground,
                      ),
                    ),
                    if (hasChildren) ...[
                      const SizedBox(width: 4),
                      AnimatedRotation(
                        turns: _hovered ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: (highlighted ? t.accent : t.foreground)
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  margin: const EdgeInsets.only(top: 3),
                  height: 2,
                  width: highlighted ? 20.0 : 0.0,
                  decoration: BoxDecoration(
                    color: t.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
