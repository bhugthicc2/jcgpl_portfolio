import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/widgets/neu_icon_button.dart';
import 'package:jcgpl_portfolio/sections/projects/project_modal.dart';
import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';
import 'package:jcgpl_portfolio/sections/projects/widgets/project_thumbnail.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class ProjectCard extends StatefulWidget {
  final ProjectItem project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => ProjectCardState();
}

class ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  void _openModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => ProjectModal(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openModal(context),
        child: Container(
          decoration: BoxDecoration(
            color: theme.base,
            borderRadius: BorderRadius.circular(10),
            boxShadow: theme.raisedShadows,
          ),
          padding: const EdgeInsets.all(10),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.base,
              borderRadius: BorderRadius.circular(10),
              boxShadow: theme.insetShadows,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ProjectThumbnail(
                      project: widget.project,
                      hovered: _hovered,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: NeuIconButton(
                        backgroundColor: theme.foreground.withValues(
                          alpha: 0.45,
                        ),
                        onTap: () {
                          _openModal(context);
                        },
                        icon: Icons.fullscreen,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                        ],
                      ),
                      const SizedBox(height: 8),
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.techStack
                            .map((t) => TechTag(label: t))
                            .toList(),
                      ),
                    ],
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
