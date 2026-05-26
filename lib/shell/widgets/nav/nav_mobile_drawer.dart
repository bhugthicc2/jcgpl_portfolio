import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'nav_helpers.dart';
import 'neu_top_nav_theme.dart';

class NavMobileDrawer extends StatelessWidget {
  final List<NavItem> items;
  final NeuTopNavTheme theme;
  final Widget? cta;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;
  final VoidCallback onClose;

  const NavMobileDrawer({
    super.key,
    required this.items,
    required this.theme,
    required this.activeLabel,
    required this.onNavigate,
    required this.onClose,
    this.cta,
  });

  @override
  Widget build(BuildContext context) {
    final padding = theme.resolvedHorizontalPadding(
      MediaQuery.sizeOf(context).width,
    );
    return Container(
      width: double.infinity,
      color: theme.base,
      padding: EdgeInsets.fromLTRB(padding, 4, padding, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: theme.darkShadow.withValues(alpha: 0.25), height: 1),
          const SizedBox(height: 8),
          ...items.map(
            (item) => _NavMobileItem(
              item: item,
              theme: theme,
              activeLabel: activeLabel,
              onNavigate: onNavigate,
              onClose: onClose,
            ),
          ),
          if (cta != null) ...[
            const SizedBox(height: 14),
            SizedBox(width: double.infinity, child: cta),
          ],
        ],
      ),
    );
  }
}

class _NavMobileItem extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;
  final VoidCallback onClose;

  const _NavMobileItem({
    required this.item,
    required this.theme,
    required this.activeLabel,
    required this.onNavigate,
    required this.onClose,
  });

  @override
  State<_NavMobileItem> createState() => _NavMobileItemState();
}

class _NavMobileItemState extends State<_NavMobileItem> {
  bool _expanded = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.item.children.isNotEmpty;
    final isActive = isNavItemActive(widget.item, widget.activeLabel);
    final highlighted =
        isTabHighlighted(
          isActive: isActive,
          hovered: _hovered,
          pressed: false,
        ) ||
        _expanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () {
              if (hasChildren) {
                setState(() => _expanded = !_expanded);
              } else {
                widget.onClose();
                widget.onNavigate(widget.item);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: widget.theme.base,
                borderRadius: BorderRadius.circular(12),
                boxShadow: highlighted ? widget.theme.insetShadows : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.item.label,
                        style: widget.theme.linkStyle.copyWith(
                          color: highlighted
                              ? widget.theme.accent
                              : widget.theme.foreground,
                        ),
                      ),
                      if (hasChildren) ...[
                        const Spacer(),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 220),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color:
                                (highlighted
                                        ? widget.theme.accent
                                        : widget.theme.foreground)
                                    .withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.only(top: 4),
                    height: 2,
                    width: highlighted ? 20.0 : 0.0,
                    decoration: BoxDecoration(
                      color: widget.theme.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (hasChildren && _expanded)
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.item.children
                  .map(
                    (child) => _NavMobileChild(
                      child: child,
                      theme: widget.theme,
                      activeLabel: widget.activeLabel,
                      onNavigate: widget.onNavigate,
                      onClose: widget.onClose,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class _NavMobileChild extends StatefulWidget {
  final NavItem child;
  final NeuTopNavTheme theme;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;
  final VoidCallback onClose;

  const _NavMobileChild({
    required this.child,
    required this.theme,
    required this.activeLabel,
    required this.onNavigate,
    required this.onClose,
  });

  @override
  State<_NavMobileChild> createState() => _NavMobileChildState();
}

class _NavMobileChildState extends State<_NavMobileChild> {
  bool _pressed = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = isNavItemActive(widget.child, widget.activeLabel);
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
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: () {
          widget.onClose();
          widget.onNavigate(widget.child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 130),
          margin: const EdgeInsets.symmetric(vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: widget.theme.base,
            borderRadius: BorderRadius.circular(10),
            boxShadow: highlighted ? widget.theme.insetShadows : [],
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 13,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: widget.theme.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                widget.child.label,
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
