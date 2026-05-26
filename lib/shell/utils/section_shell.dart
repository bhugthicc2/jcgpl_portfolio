import 'package:flutter/material.dart';

class SectionShell extends StatelessWidget {
  final GlobalKey sectionKey;
  final Widget child;

  const SectionShell({
    super.key,
    required this.sectionKey,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: sectionKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: child,
      ),
    );
  }
}
