import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'nav_helpers.dart';
import 'neu_top_nav_theme.dart';

class NavDropdownOverlay extends StatelessWidget {
  final LayerLink link;
  final List<NavItem> items;
  final NeuTopNavTheme theme;
  final String? activeLabel;
  final Animation<double> animation;
  final Animation<Offset> slideAnimation;
  final void Function(NavItem) onNavigate;
  final VoidCallback onDismiss;

  const NavDropdownOverlay({
    super.key,
    required this.link,
    required this.items,
    required this.theme,
    required this.activeLabel,
    required this.animation,
    required this.slideAnimation,
    required this.onNavigate,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: CompositedTransformFollower(
        link: link,
        offset: const Offset(-8, 56),
        child: FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: const BoxConstraints(minWidth: 196),
                decoration: BoxDecoration(
                  color: theme.base,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: theme.lightShadow,
                      blurRadius: theme.blurRadius * 1.4,
                      offset: Offset(-theme.shadowOffset, -theme.shadowOffset),
                    ),
                    BoxShadow(
                      color: theme.darkShadow,
                      blurRadius: theme.blurRadius * 1.4,
                      offset: Offset(theme.shadowOffset, theme.shadowOffset),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items
                      .map(
                        (item) => NavDropdownItem(
                          item: item,
                          theme: theme,
                          activeLabel: activeLabel,
                          onNavigate: onNavigate,
                          onDismiss: onDismiss,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavDropdownItem extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;
  final VoidCallback onDismiss;

  const NavDropdownItem({
    super.key,
    required this.item,
    required this.theme,
    required this.activeLabel,
    required this.onNavigate,
    required this.onDismiss,
  });

  @override
  State<NavDropdownItem> createState() => _NavDropdownItemState();
}

class _NavDropdownItemState extends State<NavDropdownItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive = isNavItemActive(widget.item, widget.activeLabel);
    final highlighted = isTabHighlighted(
      isActive: isActive,
      hovered: _hovered,
      pressed: _pressed,
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () {
          widget.onDismiss();
          widget.onNavigate(widget.item);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: widget.theme.base,
            borderRadius: BorderRadius.circular(10),
            boxShadow: highlighted ? widget.theme.insetShadows : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: highlighted ? 3 : 0,
                height: 14,
                margin: EdgeInsets.only(right: highlighted ? 10 : 0),
                decoration: BoxDecoration(
                  color: widget.theme.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                widget.item.label,
                style: widget.theme.dropdownLinkStyle.copyWith(
                  color: highlighted
                      ? widget.theme.accent
                      : widget.theme.foreground.withValues(alpha: 0.72),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
