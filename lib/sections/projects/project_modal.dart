import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/widgets/neu_icon_button.dart';
import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectModal extends StatefulWidget {
  final ProjectItem project;
  const ProjectModal({super.key, required this.project});

  @override
  State<ProjectModal> createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {
  int _imageIndex = 0;

  List<String> get _images {
    if (widget.project.imagePaths != null &&
        widget.project.imagePaths!.isNotEmpty) {
      return widget.project.imagePaths!;
    }
    if (widget.project.imagePath != null) return [widget.project.imagePath!];
    return [];
  }

  void _prevImage() {
    if (_images.isEmpty) return;
    setState(
      () => _imageIndex = (_imageIndex - 1 + _images.length) % _images.length,
    );
  }

  void _nextImage() {
    if (_images.isEmpty) return;
    setState(() => _imageIndex = (_imageIndex + 1) % _images.length);
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    final screenWidth = MediaQuery.sizeOf(context).width;
    final modalWidth = (screenWidth * 0.96).clamp(720.0, 1300.0);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),

      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 720,
          maxWidth: modalWidth,
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: theme.base,
            child: Stack(
              children: [
                Positioned.fill(
                  child: _ModalImage(
                    project: widget.project,
                    imageIndex: _imageIndex,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.project.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.blue,
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
                            color: Colors.white,
                            height: 1.65,
                          ),
                        ),
                        if (widget.project.githubUrl != null ||
                            widget.project.liveDemoUrl != null) ...[
                          const SizedBox(height: 24),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              if (widget.project.githubUrl != null)
                                _LinkButton(
                                  label: 'View on GitHub',
                                  icon: Icons.code_rounded,
                                  url: widget.project.githubUrl!,
                                ),
                              if (widget.project.liveDemoUrl != null)
                                _LinkButton(
                                  label: 'Live Demo',
                                  icon: Icons.open_in_new_rounded,
                                  url: widget.project.liveDemoUrl!,
                                  filled: true,
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: NeuIconButton(
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                // Prev button
                if (_images.length > 1)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: NeuIconButton(
                        onTap: _nextImage,
                        icon: Icons.chevron_left_rounded,
                      ),
                    ),
                  ),

                // Next button
                if (_images.length > 1)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: NeuIconButton(
                        onTap: _nextImage,
                        icon: Icons.chevron_right_rounded,
                      ),
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

class _ModalImage extends StatelessWidget {
  final ProjectItem project;
  final int imageIndex;
  const _ModalImage({required this.project, required this.imageIndex});

  List<String> get _images {
    if (project.imagePaths != null && project.imagePaths!.isNotEmpty) {
      return project.imagePaths!;
    }
    if (project.imagePath != null) return [project.imagePath!];
    return [];
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          Positioned.fill(
            child: _images.isNotEmpty
                ? AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Padding(
                      key: ValueKey(_images[imageIndex]),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Image.asset(
                        _images[imageIndex],
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  )
                : Container(
                    color: theme.darkShadow.withValues(alpha: 0.08),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: theme.base,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: theme.raisedShadows,
                            ),
                            child: Icon(
                              Icons.folder_rounded,
                              size: 32,
                              color: theme.foreground.withValues(alpha: 0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

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

class TechTag extends StatelessWidget {
  final String label;
  const TechTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.darkShadow.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: theme.insetShadows,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6C8EBF),
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
