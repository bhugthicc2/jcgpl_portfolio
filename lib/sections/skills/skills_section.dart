import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';

// Data models

class SkillItem {
  final String name;
  final String? svgAsset; // local asset path
  final String? svgNetwork; // fallback network SVG (Simple Icons CDN)

  const SkillItem({required this.name, this.svgAsset, this.svgNetwork});
}

class SkillCategory {
  final String title;
  final IconData icon;
  final List<SkillItem> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

// Simple Icons CDN base — free, no API key needed
const _si = 'https://cdn.simpleicons.org';

const _categories = [
  SkillCategory(
    title: 'Frontend',
    icon: Icons.phone_android_rounded,
    skills: [
      SkillItem(name: 'Flutter', svgNetwork: '$_si/flutter/6C8EBF'),
      SkillItem(name: 'Dart', svgNetwork: '$_si/dart/6C8EBF'),
      SkillItem(
        name: 'Responsive UI',
        svgNetwork: '$_si/materialdesign/6C8EBF',
      ),
      SkillItem(
        name: 'Material Design',
        svgNetwork: '$_si/materialdesign/6C8EBF',
      ),
    ],
  ),
  SkillCategory(
    title: 'Backend / Cloud',
    icon: Icons.cloud_rounded,
    skills: [
      SkillItem(name: 'Firebase', svgNetwork: '$_si/firebase/6C8EBF'),
      SkillItem(name: 'Firestore', svgNetwork: '$_si/firebase/6C8EBF'),
      SkillItem(name: 'Firebase Auth', svgNetwork: '$_si/firebase/6C8EBF'),
    ],
  ),
  SkillCategory(
    title: 'Tools',
    icon: Icons.build_rounded,
    skills: [
      SkillItem(name: 'Git', svgNetwork: '$_si/git/6C8EBF'),
      SkillItem(name: 'GitHub', svgNetwork: '$_si/github/6C8EBF'),
      SkillItem(name: 'VS Code', svgNetwork: '$_si/visualstudiocode/6C8EBF'),
      SkillItem(name: 'Figma', svgNetwork: '$_si/figma/6C8EBF'),
    ],
  ),
  SkillCategory(
    title: 'Other',
    icon: Icons.widgets_rounded,
    skills: [
      SkillItem(name: 'REST APIs', svgNetwork: '$_si/fastapi/6C8EBF'),

      SkillItem(name: 'AES Encryption', svgNetwork: '$_si/letsencrypt/6C8EBF'),
      SkillItem(name: 'SQL Basics', svgNetwork: '$_si/mysql/6C8EBF'),
    ],
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
            r.isMobile ? _MobileGrid() : _DesktopGrid(),
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
        const Text(
          'Technologies and tools I work with',
          style: TextStyle(fontSize: 14, color: Color(0xFF4a5e7a)),
        ),
      ],
    );
  }
}

// Desktop: 2-column grid

class _DesktopGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < _categories.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _CategoryCard(category: _categories[i])),
                const SizedBox(width: 24),
                Expanded(
                  child: i + 1 < _categories.length
                      ? _CategoryCard(category: _categories[i + 1])
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Mobile: single column

class _MobileGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _categories
          .map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _CategoryCard(category: c),
            ),
          )
          .toList(),
    );
  }
}

// Category card

class _CategoryCard extends StatelessWidget {
  final SkillCategory category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(20),
        boxShadow: theme.raisedShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.base,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: theme.insetShadows,
                ),
                child: Icon(category.icon, size: 20, color: theme.accent),
              ),
              const SizedBox(width: 12),
              Text(
                category.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1e2f4d),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Skill tags wrap
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: category.skills.map((s) => _SkillTag(skill: s)).toList(),
          ),
        ],
      ),
    );
  }
}

// Skill tag with logo

class _SkillTag extends StatefulWidget {
  final SkillItem skill;
  const _SkillTag({required this.skill});

  @override
  State<_SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<_SkillTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.base,
          borderRadius: BorderRadius.circular(10),
          boxShadow: _hovered ? theme.insetShadows : theme.raisedShadows,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SkillLogo(skill: widget.skill),
            const SizedBox(width: 8),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered ? theme.accent : const Color(0xFF31456A),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Logo: tries local SVG asset, falls back to network SVG

class _SkillLogo extends StatelessWidget {
  final SkillItem skill;
  const _SkillLogo({required this.skill});

  @override
  Widget build(BuildContext context) {
    const size = 18.0;
    const color = Color(0xFF6C8EBF);

    if (skill.svgAsset != null) {
      return SvgPicture.asset(
        skill.svgAsset!,
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    if (skill.svgNetwork != null) {
      return SvgPicture.network(
        skill.svgNetwork!,
        width: size,
        height: size,
        placeholderBuilder: (_) => SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            strokeWidth: 1.5,
            color: color,
          ),
        ),
      );
    }

    // Fallback: accent dot
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
