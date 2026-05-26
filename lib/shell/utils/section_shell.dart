import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SectionShell extends StatefulWidget {
  final GlobalKey sectionKey;
  final Widget child;

  const SectionShell({
    super.key,
    required this.sectionKey,
    required this.child,
  });

  @override
  State<SectionShell> createState() => _SectionShellState();
}

class _SectionShellState extends State<SectionShell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  // bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  // void _triggerAnimation() {
  //   if (_hasAnimated) return;

  //   _hasAnimated = true;
  //   _controller.forward();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionKey.toString()),
      // onVisibilityChanged: (info) {
      //   // Animate when at least 15% visible
      //   if (info.visibleFraction > 0.15) {
      //     _triggerAnimation();
      //   }
      // },
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: KeyedSubtree(
        key: widget.sectionKey,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
