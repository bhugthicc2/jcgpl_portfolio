import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/sections/projects/data/projects_data.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';

// Data model

class ProjectItem {
  final String title;
  final String description;
  final String? imagePath;
  final List<String> techStack;
  final ProjectStatus status;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.techStack,
    this.imagePath,
    this.status = ProjectStatus.completed,
  });
}

enum ProjectStatus { completed, inProgress, archived }

extension ProjectStatusX on ProjectStatus {
  String get label => switch (this) {
    ProjectStatus.completed => 'Completed',
    ProjectStatus.inProgress => 'In Progress',
    ProjectStatus.archived => 'Archived',
  };

  Color get color => switch (this) {
    ProjectStatus.completed => const Color(0xFF4CAF82),
    ProjectStatus.inProgress => const Color(0xFF6C8EBF),
    ProjectStatus.archived => const Color(0xFFA3B1C6),
  };
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
          vertical: 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeading(r: r),
            const SizedBox(height: 36),
            r.isMobile
                ? _MobileGrid()
                : r.isTablet
                ? _ProjectGrid(columns: 2)
                : _ProjectGrid(columns: 3),
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
          'Things I\'ve built',
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
          ),
        ),
      ],
    );
  }
}

// Desktop grid — configurable columns

class _ProjectGrid extends StatelessWidget {
  final int columns;
  const _ProjectGrid({required this.columns});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (int i = 0; i < ProjectsData.projects.length; i += columns) {
      final rowItems = ProjectsData.projects.sublist(
        i,
        (i + columns).clamp(0, ProjectsData.projects.length),
      );

      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < rowItems.length; j++) ...[
                if (j > 0) const SizedBox(width: 24),
                Expanded(child: _ProjectCard(project: rowItems[j])),
              ],
              // Fill empty slots in last row
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

// Mobile: single column

class _MobileGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: ProjectsData.projects
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _ProjectCard(project: p),
            ),
          )
          .toList(),
    );
  }
}

// Project card

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: theme.base,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hovered ? theme.insetShadows : theme.raisedShadows,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            _ProjectThumbnail(project: widget.project, hovered: _hovered),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row + status badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1e2f4d),
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _StatusBadge(status: widget.project.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    widget.project.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4a5e7a),
                      height: 1.65,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 14),
                  // Tech stack tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.project.techStack
                        .map((t) => _TechTag(label: t))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Thumbnail — shows image or placeholder

class _ProjectThumbnail extends StatelessWidget {
  final ProjectItem project;
  final bool hovered;

  const _ProjectThumbnail({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hovered
              ? theme.accent.withValues(alpha: 0.12)
              : theme.darkShadow.withValues(alpha: 0.08),
        ),
        child: project.imagePath != null
            ? Image.asset(
                project.imagePath!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
            : _ThumbnailPlaceholder(title: project.title, hovered: hovered),
      ),
    );
  }
}

class _ThumbnailPlaceholder extends StatelessWidget {
  final String title;
  final bool hovered;

  const _ThumbnailPlaceholder({required this.title, required this.hovered});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.base,
              borderRadius: BorderRadius.circular(14),
              boxShadow: hovered ? theme.insetShadows : theme.raisedShadows,
            ),
            child: Icon(
              Icons.folder_rounded,
              size: 24,
              color: hovered
                  ? theme.accent
                  : theme.foreground.withValues(alpha: 0.3),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: hovered
                  ? theme.accent
                  : theme.foreground.withValues(alpha: 0.3),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// Status badge

class _StatusBadge extends StatelessWidget {
  final ProjectStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(8),
        boxShadow: theme.insetShadows,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: status.color,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: status.color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Tech stack tag

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(8),
        boxShadow: theme.raisedShadows,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: theme.accent,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
