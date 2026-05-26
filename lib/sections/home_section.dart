import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/core/theme/responsive.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';
import 'package:jcgpl_portfolio/widgets/animated_role_text.dart';
import 'package:jcgpl_portfolio/widgets/availability_badge_pill.dart';
import 'package:jcgpl_portfolio/widgets/neu_avatar_frame.dart';
import 'package:jcgpl_portfolio/widgets/neu_cta_button_filled.dart';
import 'package:jcgpl_portfolio/widgets/neu_divider.dart';

class LandingSection extends StatelessWidget {
  const LandingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) => Padding(
        padding: EdgeInsets.symmetric(horizontal: r.horizontalPadding),
        child: r.isMobile ? _MobileLayout(r: r) : _DesktopLayout(r: r),
      ),
    );
  }
}

// Desktop: side-by-side Row
class _DesktopLayout extends StatelessWidget {
  final Responsive r;
  const _DesktopLayout({required this.r});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: r.sectionHeight,
      child: Row(
        children: [
          Expanded(child: _InfoContent(r: r)),
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
  const _MobileLayout({required this.r});

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
          _InfoContent(r: r),
        ],
      ),
    );
  }
}

// Shared info content — used by both layouts
class _InfoContent extends StatelessWidget {
  final Responsive r;
  const _InfoContent({required this.r});

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
          "A Computer Science student focused on Flutter development, Firebase systems, and modern cross-platform applications — turning ideas into smooth, production-ready experiences.",
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
              onTap: () {},
              theme: const NeuTopNavTheme(),
            ),
            NeuCtaButton(
              label: "Contact Me",
              onTap: () {},
              theme: const NeuTopNavTheme(),
            ),
          ],
        ),
      ],
    );
  }
}
