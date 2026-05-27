import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class ProjectThumbnail extends StatelessWidget {
  final ProjectItem project;
  final bool hovered;

  const ProjectThumbnail({
    super.key,
    required this.project,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 230,
        width: double.infinity,
        decoration: BoxDecoration(
          color: hovered
              ? theme.accent.withValues(alpha: 0.12)
              : theme.darkShadow.withValues(alpha: 0.08),
        ),
        child: project.imagePath != null
            ? AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                scale: hovered ? 1.05 : 1.0,
                child: Image.asset(
                  project.imagePath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
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
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.base,
              borderRadius: BorderRadius.circular(10),
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
