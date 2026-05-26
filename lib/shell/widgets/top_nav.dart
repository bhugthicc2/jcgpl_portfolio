import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'nav/nav_bar.dart';
import 'nav/nav_mobile_drawer.dart';
import 'nav/neu_top_nav_theme.dart';

export 'nav/neu_top_nav_theme.dart';

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

class TopNav extends StatefulWidget {
  final Widget? logo;
  final List<NavItem> items;
  final Widget? cta;
  final NeuTopNavTheme theme;
  final String? activeItemLabel;

  const TopNav({
    super.key,
    this.logo,
    this.items = const [],
    this.cta,
    this.theme = const NeuTopNavTheme(),
    this.activeItemLabel,
  });

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  bool _mobileMenuOpen = false;

  void _navigateTo(NavItem item) {
    if (item.onTap != null) {
      item.onTap!();
    } else if (item.route != null) {
      Navigator.of(context).pushReplacementNamed(item.route!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive(context).isMobileOrTablet;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NavBar(
          logo: widget.logo,
          items: widget.items,
          cta: widget.cta,
          theme: widget.theme,
          isMobile: isMobile,
          mobileMenuOpen: _mobileMenuOpen,
          activeLabel: widget.activeItemLabel,
          onNavigate: _navigateTo,
          onMobileMenuToggle: () =>
              setState(() => _mobileMenuOpen = !_mobileMenuOpen),
        ),
        if (isMobile && _mobileMenuOpen)
          NavMobileDrawer(
            items: widget.items,
            theme: widget.theme,
            cta: widget.cta,
            activeLabel: widget.activeItemLabel,
            onNavigate: _navigateTo,
            onClose: () => setState(() => _mobileMenuOpen = false),
          ),
      ],
    );
  }
}
