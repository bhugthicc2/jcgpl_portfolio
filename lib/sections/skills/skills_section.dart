import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';
import 'package:simple_icons/simple_icons.dart';

// Data model

class SkillItem {
  final String name;
  final IconData icon;
  final Color brandColor;

  const SkillItem({
    required this.name,
    required this.icon,
    required this.brandColor,
  });
}

const _skills = [
  // Frontend
  SkillItem(
    name: 'Flutter',
    icon: SimpleIcons.flutter,
    brandColor: Color(0xFF54C5F8),
  ),
  SkillItem(
    name: 'Dart',
    icon: SimpleIcons.dart,
    brandColor: Color(0xFF00B4AB),
  ),
  SkillItem(
    name: 'HTML',
    icon: SimpleIcons.html5,
    brandColor: Color(0xFFE34C26),
  ),
  SkillItem(name: 'CSS', icon: SimpleIcons.css3, brandColor: Color(0xFF1572B6)),
  SkillItem(
    name: 'Javascript',
    icon: SimpleIcons.javascript,
    brandColor: Color(0xFFFFCA28),
  ),
  // Backend / Cloud
  SkillItem(
    name: 'Firebase',
    icon: SimpleIcons.firebase,
    brandColor: Color(0xFFFFCA28),
  ),
  SkillItem(
    name: 'Firestore',
    icon: SimpleIcons.firebase,
    brandColor: Color(0xFFFFCA28),
  ),
  SkillItem(
    name: 'Firebase Auth',
    icon: SimpleIcons.firebase,
    brandColor: Color(0xFFFFCA28),
  ),
  SkillItem(
    name: 'SQL',
    icon: SimpleIcons.mysql,
    brandColor: Color(0xFF4479A1),
  ),
  SkillItem(
    name: 'REST APIs',
    icon: SimpleIcons.fastapi,
    brandColor: Color(0xFF009688),
  ),
  SkillItem(
    name: 'Railway',
    icon: SimpleIcons.railway,
    brandColor: Color(0xFF4285F4),
  ),

  // Tools
  SkillItem(name: 'Git', icon: SimpleIcons.git, brandColor: Color(0xFFF05032)),
  SkillItem(
    name: 'GitHub',
    icon: SimpleIcons.github,
    brandColor: Color(0xFF181717),
  ),
  SkillItem(
    name: 'Figma',
    icon: SimpleIcons.figma,
    brandColor: Color(0xFFF24E1E),
  ),

  // Other
  SkillItem(
    name: 'AES Encryption',
    icon: SimpleIcons.letsencrypt,
    brandColor: Color(0xFF003A70),
  ),
];

// Section root

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.horizontalPadding,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeading(r: r),
            const SizedBox(height: 36),
            _SkillGrid(r: r),
          ],
        ),
      ),
    );
  }
}

// Heading

class _SectionHeading extends StatelessWidget {
  final Responsive r;
  const _SectionHeading({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Technologies',
          style: TextStyle(
            fontSize: r.headingFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1e2f4d),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        const NeuDivider(),
        const SizedBox(height: 8),
        Text(
          'Technologies and tools I work with',
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
          ),
        ),
      ],
    );
  }
}

// Responsive grid

class _SkillGrid extends StatelessWidget {
  final Responsive r;
  const _SkillGrid({required this.r});

  int get _columns => r.isMobile
      ? 3
      : r.isTablet
      ? 4
      : 5;

  @override
  Widget build(BuildContext context) {
    final cols = _columns;
    final rows = <Widget>[];

    for (int i = 0; i < _skills.length; i += cols) {
      final rowItems = _skills.sublist(i, (i + cols).clamp(0, _skills.length));

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowItems.length; j++) ...[
                if (j > 0) const SizedBox(width: 16),
                Expanded(child: _SkillCard(skill: rowItems[j])),
              ],
              // Fill empty slots in the last row
              for (int k = rowItems.length; k < cols; k++) ...[
                const SizedBox(width: 16),
                const Expanded(child: SizedBox.shrink()),
              ],
            ],
          ),
        ),
      );
    }

    return Column(children: rows);
  }
}

// Individual skill card

class _SkillCard extends StatefulWidget {
  final SkillItem skill;
  const _SkillCard({required this.skill});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_hovered ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        decoration: BoxDecoration(
          color: theme.base,
          borderRadius: BorderRadius.circular(20),
          boxShadow: theme.raisedShadows,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon container — shadow swaps on hover
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: theme.base,
                borderRadius: BorderRadius.circular(16),
                boxShadow: theme.insetShadows,
              ),
              child: Center(
                child: Icon(
                  widget.skill.icon,
                  size: 32,
                  // Use brand color at full opacity when hovered,
                  // slightly muted at rest
                  color: widget.skill.brandColor.withValues(
                    alpha: _hovered ? 1.0 : 0.75,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.skill.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _hovered ? theme.accent : const Color(0xFF31456A),
                letterSpacing: 0.2,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
