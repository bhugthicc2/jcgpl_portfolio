import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/projects/data/projects_data.dart';
import 'package:jcgpl_portfolio/sections/projects/project_modal.dart';
import 'package:jcgpl_portfolio/sections/projects/widgets/project_card.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';
import 'package:url_launcher/url_launcher.dart';

// Data model

class ProjectItem {
  final String title;
  final String description;
  final String? imagePath;
  final List<String>? imagePaths;
  final List<String> techStack;
  final String? githubUrl;
  final String? liveDemoUrl;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    this.imagePath,
    this.imagePaths,
    this.githubUrl,
    this.liveDemoUrl,
  });
}

// Section root

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
            r.isMobile ? _ProjectGrid(columns: 1) : _ProjectGrid(columns: 2),
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
          'Projects',
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
          "Things I've built",
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
          ),
        ),
      ],
    );
  }
}

// Grid

class _ProjectGrid extends StatelessWidget {
  final int columns;
  const _ProjectGrid({required this.columns});

  @override
  Widget build(BuildContext context) {
    final projects = ProjectsData.projects;
    final rows = <Widget>[];

    for (int i = 0; i < projects.length; i += columns) {
      final rowItems = projects.sublist(
        i,
        (i + columns).clamp(0, projects.length),
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowItems.length; j++) ...[
                if (j > 0) const SizedBox(width: 24),
                Expanded(child: ProjectCard(project: rowItems[j])),
              ],
              for (int k = rowItems.length; k < columns; k++) ...[
                const SizedBox(width: 24),
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

// Link button

class _LinkButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool filled;

  const _LinkButton({
    required this.label,
    required this.icon,
    required this.url,
    this.filled = false,
  });

  @override
  State<_LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<_LinkButton> {
  bool _hovered = false;
  bool _pressed = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    final active = _hovered || _pressed;

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
          _launch();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: widget.filled ? theme.accent : theme.base,
            borderRadius: BorderRadius.circular(12),
            boxShadow: active ? theme.insetShadows : theme.raisedShadows,
            border: widget.filled
                ? null
                : Border.all(
                    color: theme.accent.withValues(alpha: active ? 0.45 : 0.0),
                    width: 1.5,
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.filled
                    ? Colors.white
                    : active
                    ? theme.accent
                    : theme.foreground,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: widget.filled
                      ? Colors.white
                      : active
                      ? theme.accent
                      : theme.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
