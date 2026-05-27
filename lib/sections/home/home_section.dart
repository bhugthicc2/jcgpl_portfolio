import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'package:jcgpl_portfolio/sections/home/widgets/animated_role_text.dart';
import 'package:jcgpl_portfolio/sections/home/widgets/availability_badge_pill.dart';
import 'package:jcgpl_portfolio/sections/home/widgets/neu_avatar_frame.dart';
import 'package:jcgpl_portfolio/widgets/neu_cta_button.dart';
import 'package:jcgpl_portfolio/sections/home/widgets/neu_cta_button_filled.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:url_launcher/url_launcher.dart';

class LandingSection extends StatelessWidget {
  final VoidCallback onContactTap;
  const LandingSection({super.key, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) => Padding(
        padding: EdgeInsets.symmetric(horizontal: r.horizontalPadding),
        child: r.isMobile
            ? _MobileLayout(r: r, onContactTap: onContactTap)
            : _DesktopLayout(r: r, onContactTap: onContactTap),
      ),
    );
  }
}

// Desktop: side-by-side Row
class _DesktopLayout extends StatelessWidget {
  final Responsive r;
  final VoidCallback onContactTap;
  const _DesktopLayout({required this.r, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: r.sectionHeight,
      child: Row(
        children: [
          Expanded(
            child: _InfoContent(r: r, onContactTap: onContactTap),
          ),
          Expanded(
            child: Center(
              child: NeuAvatarFrame(
                size: r.avatarSize,
                child: Image.asset(
                  'assets/images/profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Mobile: stacked Column
class _MobileLayout extends StatelessWidget {
  final Responsive r;
  final VoidCallback onContactTap;
  const _MobileLayout({required this.r, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          NeuAvatarFrame(
            size: r.avatarSize,
            child: Image.asset('assets/images/profile.png', fit: BoxFit.cover),
          ),
          const SizedBox(height: 32),
          _InfoContent(r: r, onContactTap: onContactTap),
        ],
      ),
    );
  }
}

// Shared info content — used by both layouts
class _InfoContent extends StatelessWidget {
  final Responsive r;
  final VoidCallback onContactTap;
  const _InfoContent({required this.r, required this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AvailabilityBadge(),
        const SizedBox(height: 14),
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: r.bodyFontSize + 4,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF31456A),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Jesie Gapol",
          style: TextStyle(
            fontSize: r.displayFontSize,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1e2f4d),
            letterSpacing: -0.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedRoleText(
          roles: const ["FLUTTER DEVELOPER", "GRAPHIC ARTIST"],
          theme: const NeuTopNavTheme(),
        ),
        const SizedBox(height: 16),
        const NeuDivider(),
        const SizedBox(height: 16),
        Text(
          "A Computer Science student focused on Flutter development, Firebase systems, and modern cross-platform applications turning ideas into smooth, production-ready experiences.",
          style: TextStyle(
            fontSize: r.bodyFontSize,
            color: const Color(0xFF4a5e7a),
            height: 1.75,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            NeuCtaButtonFilled(
              label: "Download CV",
              onTap: _downloadCV,
              theme: const NeuTopNavTheme(),
            ),
            NeuCtaButton(
              label: "Contact Me",
              onTap: onContactTap,
              theme: const NeuTopNavTheme(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _downloadCV() async {
    if (kIsWeb) {
      final href = Uri.base
          .resolve('assets/assets/cv/Jesie_Gapol_CV.pdf')
          .toString();
      html.AnchorElement(href: href)
        ..setAttribute('download', 'Jesie_Gapol_CV.pdf')
        ..click();
      return;
    }
    // Mobile fallback
    final uri = Uri.parse(
      'https://drive.google.com/file/d/1rhXGQDRWRHurO5rDJ_Ixxa_NFVrQdfsF/view?usp=sharing',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
