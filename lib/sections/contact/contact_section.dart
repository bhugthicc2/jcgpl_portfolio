import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/widgets/neu_text_field.dart';
import 'package:jcgpl_portfolio/sections/contact/data/contact_data.dart'
    as ContactLink;
import 'package:jcgpl_portfolio/sections/contact/data/contact_data.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/shell/widgets/nav/neu_top_nav_theme.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';

// ── Section root ──────────────────────────────────────────────────────────────

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: r.horizontalPadding,
          vertical: 64,
        ),
        child: r.isMobile ? _MobileLayout(r: r) : _DesktopLayout(r: r),
      ),
    );
  }
}

// ── Desktop: left info + right form ──────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final Responsive r;
  const _DesktopLayout({required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 4, child: _ContactInfo(r: r)),
        const SizedBox(width: 48),
        Expanded(flex: 5, child: _ContactForm()),
      ],
    );
  }
}

// ── Mobile: stacked ───────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final Responsive r;
  const _MobileLayout({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactInfo(r: r),
        const SizedBox(height: 40),
        _ContactForm(),
      ],
    );
  }
}

// ── Left: heading + blurb + social links ─────────────────────────────────────

class _ContactInfo extends StatelessWidget {
  final Responsive r;
  const _ContactInfo({required this.r});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get In Touch",
          style: TextStyle(
            fontSize: r.headingFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1e2f4d),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 10),
        const NeuDivider(),
        const SizedBox(height: 16),
        Text(
          "I'm currently open to new opportunities. Whether you have a project "
          "in mind, a question, or just want to say hi my inbox is open.",
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
            height: 1.75,
          ),
        ),
        const SizedBox(height: 32),
        ...ContactLink.links.map((l) => _SocialCard(link: l)),
      ],
    );
  }
}

// ── Social link card ──────────────────────────────────────────────────────────

class _SocialCard extends StatefulWidget {
  final ContactLink.ContactLink link;
  const _SocialCard({required this.link});

  @override
  State<_SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<_SocialCard> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.base,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _hovered ? theme.insetShadows : theme.raisedShadows,
          ),
          child: Row(
            children: [
              // Icon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.base,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _hovered
                      ? theme.raisedShadows
                      : theme.insetShadows,
                ),
                child: Icon(
                  widget.link.icon,
                  size: 20,
                  color: _hovered
                      ? widget.link.brandColor
                      : theme.foreground.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.link.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.foreground.withValues(alpha: 0.45),
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.link.value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _hovered ? theme.accent : theme.foreground,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AnimatedOpacity(
                opacity: _hovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: theme.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Right: contact form ───────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _sending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) return;

    setState(() => _sending = true);

    // Opens the device mail client pre-filled — no backend needed
    final uri = Uri(
      scheme: 'mailto',
      path: 'you@email.com',
      query: Uri.encodeFull(
        'subject=Portfolio Contact — $name&body=$message\n\nFrom: $name\nEmail: $email',
      ),
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }

    setState(() {
      _sending = false;
      _sent = true;
    });

    // Reset after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _sent = false;
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme();
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: theme.base,
        borderRadius: BorderRadius.circular(24),
        boxShadow: theme.raisedShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send a Message",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1e2f4d),
            ),
          ),
          const SizedBox(height: 24),
          NeuTextField(
            controller: _nameCtrl,
            label: 'Name',
            hint: 'Your name',
            icon: Icons.person_rounded,
          ),
          const SizedBox(height: 16),
          NeuTextField(
            controller: _emailCtrl,
            label: 'Email',
            hint: 'your@email.com',
            icon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          NeuTextField(
            controller: _messageCtrl,
            label: 'Message',
            hint: 'What would you like to say?',
            icon: Icons.message_rounded,
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          _SubmitButton(sending: _sending, sent: _sent, onTap: _submit),
        ],
      ),
    );
  }
}

// ── Submit button ─────────────────────────────────────────────────────────────

class _SubmitButton extends StatefulWidget {
  final bool sending;
  final bool sent;
  final VoidCallback onTap;

  const _SubmitButton({
    required this.sending,
    required this.sent,
    required this.onTap,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;
  bool _pressed = false;

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
          if (!widget.sending && !widget.sent) widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: widget.sent ? const Color(0xFF4CAF82) : theme.accent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: active || widget.sending
                ? theme.insetShadows
                : theme.raisedShadows,
          ),
          child: Center(
            child: widget.sending
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.sent ? Icons.check_rounded : Icons.send_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.sent ? "Message Sent!" : "Send Message",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
