import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

bool isNavItemActive(NavItem item, String? activeLabel) {
  if (activeLabel == null) return false;
  if (item.label == activeLabel) return true;
  return item.children.any((c) => isNavItemActive(c, activeLabel));
}

bool isTabHighlighted({
  required bool isActive,
  required bool hovered,
  required bool pressed,
}) => isActive || hovered || pressed;
