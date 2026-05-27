import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';

class NeuTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;

  const NeuTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  State<NeuTextField> createState() => NeuTextFieldState();
}

class NeuTextFieldState extends State<NeuTextField> {
  bool _focused = false;
  bool get _isMultiline => widget.maxLines > 1;

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: theme.foreground.withValues(alpha: 0.5),
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        // Input container
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: theme.base,
            borderRadius: BorderRadius.circular(12),
            boxShadow: theme.insetShadows,
            border: Border.all(
              color: _focused
                  ? theme.accent.withValues(alpha: 0.5)
                  : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Focus(
            onFocusChange: (v) => setState(() => _focused = v),
            child: _isMultiline
                ? _MultilineField(widget: widget, focused: _focused)
                : _SingleLineField(widget: widget, focused: _focused),
          ),
        ),
      ],
    );
  }
}

// Single-line: icon left, text vertically centered

class _SingleLineField extends StatelessWidget {
  final NeuTextField widget;
  final bool focused;

  const _SingleLineField({required this.widget, required this.focused});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          widget.icon,
          size: 18,
          color: focused
              ? theme.accent
              : theme.foreground.withValues(alpha: 0.35),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              color: theme.foreground,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: theme.foreground.withValues(alpha: 0.3),
              ),
              border: InputBorder.none,
              // Symmetric vertical padding centers the text in the field
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}

// Multiline: icon top-left aligned, text scrolls below

class _MultilineField extends StatelessWidget {
  final NeuTextField widget;
  final bool focused;

  const _MultilineField({required this.widget, required this.focused});

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 14),
          child: Icon(
            widget.icon,
            size: 18,
            color: focused
                ? theme.accent
                : theme.foreground.withValues(alpha: 0.35),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            style: TextStyle(
              fontSize: 13,
              color: theme.foreground,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: theme.foreground.withValues(alpha: 0.3),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 0,
              ),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(width: 14),
      ],
    );
  }
}
