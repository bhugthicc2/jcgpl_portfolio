import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/dimensions.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';

class NavItem {
  final String label;
  final String? route;
  final VoidCallback? onTap;
  final List<NavItem> children;

  const NavItem({
    required this.label,
    this.route,
    this.onTap,
    this.children = const [],
  });
}

// Neumorphic Theme

class NeuTopNavTheme {
  final Color base; // The "surface" colour everything is carved from
  final Color lightShadow; // Highlight corner shadow
  final Color darkShadow; // Depth corner shadow
  final Color foreground; // Text / icon colour
  final Color accent; // Active / hover accent colour
  final double height;

  /// Maximum horizontal padding on wide screens.
  final double horizontalPadding;

  /// Minimum horizontal padding on narrow screens.
  final double minHorizontalPadding;
  final double blurRadius;
  final double shadowOffset;
  final TextStyle linkStyle;
  final TextStyle dropdownLinkStyle;

  const NeuTopNavTheme({
    this.base = const Color(0xFFE0E5EC),
    this.lightShadow = const Color(0xFFFFFFFF),
    this.darkShadow = const Color(0xFFA3B1C6),
    this.foreground = const Color(0xFF31456A),
    this.accent = const Color(0xFF6C8EBF),
    this.height = 68,
    this.horizontalPadding = Dimensions.desktopHorizontalPadding,
    this.minHorizontalPadding = 30,
    this.blurRadius = 18,
    this.shadowOffset = 6,
    this.linkStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
    ),
    this.dropdownLinkStyle = const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    ),
  });

  /// Convenience: raised (extruded) shadow lista
  List<BoxShadow> get raisedShadows => [
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius,
      offset: Offset(-shadowOffset, -shadowOffset),
    ),
    BoxShadow(
      color: darkShadow,
      blurRadius: blurRadius,
      offset: Offset(shadowOffset, shadowOffset),
    ),
  ];

  /// Inset / pressed shadow list — simulates a depressed button
  List<BoxShadow> get insetShadows => [
    BoxShadow(
      color: darkShadow,
      blurRadius: blurRadius * 0.6,
      offset: Offset(shadowOffset * 0.6, shadowOffset * 0.6),
    ),
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius * 0.6,
      offset: Offset(-shadowOffset * 0.6, -shadowOffset * 0.6),
    ),
  ];

  /// Scales from [minHorizontalPadding] below [_kMobileBreakpoint] to
  /// [horizontalPadding] at [_kMaxPaddingWidth] and above.
  double resolvedHorizontalPadding(double screenWidth) {
    final r = Responsive.fromWidth(screenWidth);
    return r.horizontalPadding;
  }

  /// Subtle inner glow for hover state
  List<BoxShadow> get hoverShadows => [
    BoxShadow(
      color: lightShadow,
      blurRadius: blurRadius * 1.1,
      offset: Offset(-shadowOffset * 0.8, -shadowOffset * 0.8),
    ),
    BoxShadow(
      color: darkShadow.withValues(alpha: 0.6),
      blurRadius: blurRadius * 1.1,
      offset: Offset(shadowOffset * 0.8, shadowOffset * 0.8),
    ),
  ];

  // Pre-built dark variant
  static const NeuTopNavTheme dark = NeuTopNavTheme(
    base: Color(0xFF2D2D3A),
    lightShadow: Color(0xFF3D3D4E),
    darkShadow: Color(0xFF1A1A24),
    foreground: Color(0xFFD0D8EE),
    accent: Color(0xFF7B9FD4),
  );
}

bool _isNavItemActive(NavItem item, String? activeRoute) {
  if (activeRoute == null) return false;
  if (item.route != null && item.route == activeRoute) return true;
  return item.children.any((c) => _isNavItemActive(c, activeRoute));
}

/// Active tab and hover share the same pressed-in neumorphic treatment.
bool _isTabHighlighted({
  required bool isActive,
  required bool hovered,
  required bool pressed,
}) => isActive || hovered || pressed;

// Public Widget

class TopNav extends StatefulWidget {
  final Widget? logo;
  final List<NavItem> items;
  final Widget? cta;
  final NeuTopNavTheme theme;

  const TopNav({
    super.key,
    this.logo,
    this.items = const [],
    this.cta,
    this.theme = const NeuTopNavTheme(),
  });

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  bool _mobileMenuOpen = false;
  String? _activeRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activeRoute = ModalRoute.of(context)?.settings.name;
  }

  void _selectRoute(String route) {
    if (_activeRoute != route) {
      setState(() => _activeRoute = route);
    }
  }

  void _navigateTo(BuildContext context, NavItem item) {
    final route = item.route;
    if (route != null) {
      _selectRoute(route);
    }
    if (item.onTap != null) {
      item.onTap!();
    } else if (route != null) {
      Navigator.of(context).pushReplacementNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive(context).isMobileOrTablet;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _NeuNavBar(
          logo: widget.logo,
          items: widget.items,
          cta: widget.cta,
          theme: widget.theme,
          isMobile: isMobile,
          mobileMenuOpen: _mobileMenuOpen,
          activeRoute: _activeRoute,
          onNavigate: (item) => _navigateTo(context, item),
          onMobileMenuToggle: () =>
              setState(() => _mobileMenuOpen = !_mobileMenuOpen),
        ),
        if (isMobile && _mobileMenuOpen)
          _NeuMobileDrawer(
            items: widget.items,
            theme: widget.theme,
            cta: widget.cta,
            activeRoute: _activeRoute,
            onNavigate: (item) => _navigateTo(context, item),
            onClose: () => setState(() => _mobileMenuOpen = false),
          ),
      ],
    );
  }
}

// Nav Bar Shell

class _NeuNavBar extends StatelessWidget {
  final Widget? logo;
  final List<NavItem> items;
  final Widget? cta;
  final NeuTopNavTheme theme;
  final bool isMobile;
  final bool mobileMenuOpen;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onMobileMenuToggle;

  const _NeuNavBar({
    required this.logo,
    required this.items,
    required this.cta,
    required this.theme,
    required this.isMobile,
    required this.mobileMenuOpen,
    required this.activeRoute,
    required this.onNavigate,
    required this.onMobileMenuToggle,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = theme.resolvedHorizontalPadding(
      MediaQuery.sizeOf(context).width,
    );

    return Container(
      height: theme.height,

      // Neumorphic bar: flat raised panel
      decoration: BoxDecoration(
        color: theme.base,
        boxShadow: [
          BoxShadow(
            color: theme.lightShadow,
            blurRadius: theme.blurRadius * 1.2,
            offset: Offset(
              -theme.shadowOffset * 0.8,
              -theme.shadowOffset * 0.8,
            ),
          ),
          BoxShadow(
            color: theme.darkShadow,
            blurRadius: theme.blurRadius * 1.2,
            offset: Offset(theme.shadowOffset * 0.8, theme.shadowOffset * 0.8),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          if (logo != null) logo!,
          const Spacer(),
          if (!isMobile) ...[
            ...items.map(
              (item) => _NeuDesktopNavItem(
                item: item,
                theme: theme,
                activeRoute: activeRoute,
                onNavigate: onNavigate,
              ),
            ),
            if (cta != null) ...[const SizedBox(width: 20), cta!],
          ],
          if (isMobile)
            _NeuHamburgerButton(
              open: mobileMenuOpen,
              theme: theme,
              onTap: onMobileMenuToggle,
            ),
        ],
      ),
    );
  }
}

// Desktop Nav Item

class _NeuDesktopNavItem extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;

  const _NeuDesktopNavItem({
    required this.item,
    required this.theme,
    required this.activeRoute,
    required this.onNavigate,
  });

  @override
  State<_NeuDesktopNavItem> createState() => _NeuDesktopNavItemState();
}

class _NeuDesktopNavItemState extends State<_NeuDesktopNavItem>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  OverlayEntry? _overlay;
  final LayerLink _link = LayerLink();

  NeuTopNavTheme get t => widget.theme;
  NavItem get item => widget.item;
  bool get hasChildren => item.children.isNotEmpty;

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
    _removeOverlay();
    _ctrl.dispose();
    super.dispose();
  }

  void _showOverlay() {
    _overlay = OverlayEntry(
      builder: (_) => _NeuDropdownOverlay(
        link: _link,
        items: item.children,
        theme: t,
        activeRoute: widget.activeRoute,
        animation: _fade,
        slideAnimation: _slide,
        onNavigate: widget.onNavigate,
        onDismiss: _removeOverlay,
      ),
    );
    Overlay.of(context).insert(_overlay!);
    _ctrl.forward();
  }

  void _removeOverlay() {
    _ctrl.reverse().then((_) {
      _overlay?.remove();
      _overlay = null;
    });
  }

  void _onEnter() {
    setState(() => _hovered = true);
    if (hasChildren && _overlay == null) _showOverlay();
  }

  void _onExit() {
    setState(() {
      _hovered = false;
      _pressed = false;
    });
    if (hasChildren) _removeOverlay();
  }

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  void _onTap() => widget.onNavigate(item);

  @override
  Widget build(BuildContext context) {
    final isActive = _isNavItemActive(item, widget.activeRoute);
    final highlighted = _isTabHighlighted(
      isActive: isActive,
      hovered: _hovered,
      pressed: _pressed,
    );

    return CompositedTransformTarget(
      link: _link,
      child: MouseRegion(
        onEnter: (_) => _onEnter(),
        onExit: (_) => _onExit(),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: hasChildren ? null : _onTapDown,
          onTapUp: hasChildren ? null : _onTapUp,
          onTapCancel: hasChildren ? null : _onTapCancel,
          onTap: hasChildren ? null : _onTap,
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
                      item.label,
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

// Dropdown Overlay

class _NeuDropdownOverlay extends StatelessWidget {
  final LayerLink link;
  final List<NavItem> items;
  final NeuTopNavTheme theme;
  final String? activeRoute;
  final Animation<double> animation;
  final Animation<Offset> slideAnimation;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onDismiss;

  const _NeuDropdownOverlay({
    required this.link,
    required this.items,
    required this.theme,
    required this.activeRoute,
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(minWidth: 196),
                decoration: BoxDecoration(
                  color: theme.base,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    // Outer neumorphic depth
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
                        (child) => _NeuDropdownItem(
                          item: child,
                          theme: theme,
                          activeRoute: activeRoute,
                          onNavigate: onNavigate,
                          onTap: onDismiss,
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

// Dropdown Item

class _NeuDropdownItem extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onTap;

  const _NeuDropdownItem({
    required this.item,
    required this.theme,
    required this.activeRoute,
    required this.onNavigate,
    required this.onTap,
  });

  @override
  State<_NeuDropdownItem> createState() => _NeuDropdownItemState();
}

class _NeuDropdownItemState extends State<_NeuDropdownItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isActive =
        widget.item.route != null && widget.item.route == widget.activeRoute;
    final highlighted = _isTabHighlighted(
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
          widget.onTap();
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

// Mobile Drawer

class _NeuMobileDrawer extends StatelessWidget {
  final List<NavItem> items;
  final NeuTopNavTheme theme;
  final Widget? cta;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onClose;

  const _NeuMobileDrawer({
    required this.items,
    required this.theme,
    required this.cta,
    required this.activeRoute,
    required this.onNavigate,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = theme.resolvedHorizontalPadding(
      MediaQuery.sizeOf(context).width,
    );

    return Container(
      width: double.infinity,
      color: theme.base,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 4, horizontalPadding, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: theme.darkShadow.withValues(alpha: 0.25), height: 1),
          const SizedBox(height: 8),
          ...items.map(
            (item) => _NeuMobileNavItem(
              item: item,
              theme: theme,
              activeRoute: activeRoute,
              onNavigate: onNavigate,
              onTap: onClose,
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

// Mobile Nav Item

class _NeuMobileNavItem extends StatefulWidget {
  final NavItem item;
  final NeuTopNavTheme theme;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onTap;

  const _NeuMobileNavItem({
    required this.item,
    required this.theme,
    required this.activeRoute,
    required this.onNavigate,
    required this.onTap,
  });

  @override
  State<_NeuMobileNavItem> createState() => _NeuMobileNavItemState();
}

class _NeuMobileNavItemState extends State<_NeuMobileNavItem> {
  bool _expanded = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.item.children.isNotEmpty;
    final isActive = _isNavItemActive(widget.item, widget.activeRoute);
    final highlighted =
        _isTabHighlighted(
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
                widget.onTap();
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
              children: widget.item.children.map((child) {
                return _NeuMobileChild(
                  child: child,
                  theme: widget.theme,
                  activeRoute: widget.activeRoute,
                  onNavigate: widget.onNavigate,
                  onTap: widget.onTap,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

class _NeuMobileChild extends StatefulWidget {
  final NavItem child;
  final NeuTopNavTheme theme;
  final String? activeRoute;
  final void Function(NavItem item) onNavigate;
  final VoidCallback onTap;

  const _NeuMobileChild({
    required this.child,
    required this.theme,
    required this.activeRoute,
    required this.onNavigate,
    required this.onTap,
  });

  @override
  State<_NeuMobileChild> createState() => _NeuMobileChildState();
}

class _NeuMobileChildState extends State<_NeuMobileChild> {
  bool _pressed = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive =
        widget.child.route != null && widget.child.route == widget.activeRoute;
    final highlighted = _isTabHighlighted(
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
          widget.onTap();
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

// Hamburger Button

class _NeuHamburgerButton extends StatefulWidget {
  final bool open;
  final NeuTopNavTheme theme;
  final VoidCallback onTap;

  const _NeuHamburgerButton({
    required this.open,
    required this.theme,
    required this.onTap,
  });

  @override
  State<_NeuHamburgerButton> createState() => _NeuHamburgerButtonState();
}

class _NeuHamburgerButtonState extends State<_NeuHamburgerButton> {
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

// Reusable Neumorphic CTA Button

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
