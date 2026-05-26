import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

class AnimatedRoleText extends StatefulWidget {
  final List<String> roles;
  final NeuTopNavTheme theme;

  const AnimatedRoleText({super.key, required this.roles, required this.theme});

  @override
  State<AnimatedRoleText> createState() => AnimatedRoleTextState();
}

class AnimatedRoleTextState extends State<AnimatedRoleText> {
  int _currentIndex = 0;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startCycle();
  }

  void _startCycle() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      // Fade out
      setState(() => _visible = false);
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;

      // Swap text
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.roles.length;
        _visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.3),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        child: Text(
          widget.roles[_currentIndex],
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: widget.theme.accent,
            letterSpacing: 2.5,
          ),
        ),
      ),
    );
  }
}
