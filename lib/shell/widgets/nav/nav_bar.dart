import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'nav_hamburger.dart';
import 'nav_item_desktop.dart';
import 'neu_top_nav_theme.dart';

class NavBar extends StatelessWidget {
  final Widget? logo;
  final List<NavItem> items;
  final Widget? cta;
  final NeuTopNavTheme theme;
  final bool isMobile;
  final bool mobileMenuOpen;
  final String? activeLabel;
  final void Function(NavItem) onNavigate;
  final VoidCallback onMobileMenuToggle;

  const NavBar({
    super.key,
    required this.items,
    required this.theme,
    required this.isMobile,
    required this.mobileMenuOpen,
    required this.onNavigate,
    required this.onMobileMenuToggle,
    this.logo,
    this.cta,
    this.activeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final padding = theme.resolvedHorizontalPadding(
      MediaQuery.sizeOf(context).width,
    );
    return Container(
      height: theme.height,
      decoration: BoxDecoration(
        color: theme.base,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: theme.foreground.withValues(alpha: 0.1),
          ),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: theme.lightShadow,
        //     blurRadius: theme.blurRadius * 1.2,
        //     offset: Offset(
        //       -theme.shadowOffset * 0.8,
        //       -theme.shadowOffset * 0.8,
        //     ),
        //   ),
        //   BoxShadow(
        //     color: theme.darkShadow,
        //     blurRadius: theme.blurRadius * 1.2,
        //     offset: Offset(theme.shadowOffset * 0.8, theme.shadowOffset * 0.8),
        //   ),
        // ],
      ),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          if (logo != null) logo!,
          const Spacer(),
          if (!isMobile) ...[
            ...items.map(
              (item) => NavItemDesktop(
                item: item,
                theme: theme,
                activeLabel: activeLabel,
                onNavigate: onNavigate,
              ),
            ),
            if (cta != null) ...[const SizedBox(width: 20), cta!],
          ],
          if (isMobile)
            NavHamburger(
              open: mobileMenuOpen,
              theme: theme,
              onTap: onMobileMenuToggle,
            ),
        ],
      ),
    );
  }
}
