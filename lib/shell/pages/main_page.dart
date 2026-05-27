import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jcgpl_portfolio/sections/about/about_section.dart';
import 'package:jcgpl_portfolio/sections/contact/contact_section.dart';
import 'package:jcgpl_portfolio/sections/experience/experience_section.dart';
import 'package:jcgpl_portfolio/sections/home/home_section.dart';
import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';
import 'package:jcgpl_portfolio/sections/skills/skills_section.dart';
import 'package:jcgpl_portfolio/shell/models/portfolio_section.dart';
import 'package:jcgpl_portfolio/shell/utils/section_shell.dart';
import 'package:jcgpl_portfolio/shell/widgets/top_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();

  // One GlobalKey per section — used to measure position for scroll + active detection
  final Map<PortfolioSection, GlobalKey> _sectionKeys = {
    for (final s in PortfolioSection.values) s: GlobalKey(),
  };

  PortfolioSection _activeSection = PortfolioSection.landing;

  //NeuTopNavTheme height
  static const double _navHeight = 68;

  // Extra offset so the heading isn't hidden behind the nav
  static const double _scrollOffset = _navHeight + 12;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trigger once after first frame so activeSection isn't stale on load
    SchedulerBinding.instance.addPostFrameCallback((_) => _onScroll());
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final viewportHeight = MediaQuery.sizeOf(context).height;
    // The scroll view's own RenderBox — all measurements are relative to this
    final scrollBox =
        _scrollController.position.context.storageContext.findRenderObject()
            as RenderBox?;
    if (scrollBox == null) return;

    PortfolioSection detected = PortfolioSection.landing;

    for (final section in PortfolioSection.values) {
      final ctx = _sectionKeys[section]!.currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;

      // Position relative to the scroll view's top-left, not the screen
      final sectionTop = box.localToGlobal(Offset.zero, ancestor: scrollBox).dy;

      // Mark active once the section's top edge enters the upper 40% of the viewport
      if (sectionTop <= viewportHeight * 0.4) {
        detected = section;
      }
    }

    if (detected != _activeSection) {
      setState(() => _activeSection = detected);
    }
  }

  //  Smooth scroll to section

  Future<void> _scrollTo(PortfolioSection section) async {
    final key = _sectionKeys[section]!;
    final ctx = key.currentContext;
    if (ctx == null) return;

    // Defer until frame is ready (important if called right after a setState)
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 640),
        curve: Curves.easeInOutCubic,
        alignment: 0.0, // scroll section to top
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      ).then((_) {
        // Fine-tune: subtract nav height so the section title isn't hidden
        final target = _scrollController.offset - _scrollOffset + _navHeight;
        _scrollController.animateTo(
          target.clamp(0, _scrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
        );
      });
    });
  }

  //  Nav items built from enum
  List<NavItem> get _navItems => [
    for (final section in PortfolioSection.values)
      NavItem(
        label: section.label,
        route: section.route,
        onTap: () => _scrollTo(section),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    const theme = NeuTopNavTheme(); // or NeuTopNavTheme.dark

    return Scaffold(
      backgroundColor: theme.base,
      body: Column(
        children: [
          TopNav(
            theme: theme,
            activeItemLabel: _activeSection.label,
            logo: GestureDetector(
              onTap: () => _scrollTo(PortfolioSection.landing),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/logo.svg',
                      height: 32,

                      colorFilter: const ColorFilter.mode(
                        Color(0xFF31456A),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "JCGPL",
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF31456A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            items: _navItems,
          ),

          //  Scrollable body
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SectionShell(
                    sectionKey: _sectionKeys[PortfolioSection.landing]!,
                    child: LandingSection(
                      onContactTap: () => _scrollTo(PortfolioSection.contact),
                    ),
                  ),
                  SectionShell(
                    sectionKey: _sectionKeys[PortfolioSection.about]!,
                    child: const AboutSection(),
                  ),
                  SectionShell(
                    sectionKey: _sectionKeys[PortfolioSection.skills]!,
                    child: const SkillsSection(),
                  ),
                  SectionShell(
                    sectionKey: _sectionKeys[PortfolioSection.projects]!,
                    child: const ProjectsSection(),
                  ),
                  // SectionShell(
                  //   sectionKey: _sectionKeys[PortfolioSection.experience]!,
                  //   child: const ExperienceSection(),
                  // ),
                  SectionShell(
                    sectionKey: _sectionKeys[PortfolioSection.contact]!,
                    child: const ContactSection(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
