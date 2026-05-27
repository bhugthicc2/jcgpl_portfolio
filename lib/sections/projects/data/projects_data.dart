import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';

class ProjectsData {
  static final List<ProjectItem> projects = [
    ProjectItem(
      title: 'Cloud-based Vehicle Monitoring System',
      description:
          'A Flutter-based vehicle monitoring system using QR codes and Firebase Firestore for real-time tracking and AES-encrypted payloads.',
      imagePath: 'assets/images/projects/cvms.png',
      imagePaths: [
        'assets/images/projects/cvms4.png',
        'assets/images/projects/cvms.png',
        'assets/images/projects/cvms1.png',
        'assets/images/projects/cvms2.png',
        'assets/images/projects/cvms3.png',
      ],
      // githubUrl: 'https://github.com/bhugthicc2/cvms_mobile',
      techStack: ['Flutter', 'Firebase', 'AES', 'Firestore'],
    ),
    ProjectItem(
      title: 'JRMSU CCS QR-based Visitors Log System',
      description:
          'A QR-based visitor logging system for JRMSU CCS, built with Flutter and Firebase for real-time visitor tracking.',
      imagePath: 'assets/images/projects/visitors_log.png',
      imagePaths: [
        'assets/images/projects/visitors_log1.png',
        'assets/images/projects/visitors_log.png',
        'assets/images/projects/visitors_log2.png',
        'assets/images/projects/visitors_log3.png',
        'assets/images/projects/visitors_log4.png',
        'assets/images/projects/visitors_log5.png',
      ],
      techStack: ['Flutter', 'Dart', 'Firebase'],
    ),
    ProjectItem(
      title: 'Gapz Graphics Portfolio Website',
      description:
          'A personal graphic design portfolio website showcasing branding and visual design work.',
      imagePath: 'assets/images/projects/gapz_graphix.png',
      techStack: ['HTML', 'CSS', 'Javascript'],
      imagePaths: [
        'assets/images/projects/gapz_graphix1.png',
        'assets/images/projects/gapz_graphix.png',
        'assets/images/projects/gapz_graphix2.png',
        'assets/images/projects/gapz_graphix3.png',
        'assets/images/projects/gapz_graphix4.png',
        'assets/images/projects/gapz_graphix5.png',
      ],
    ),
    ProjectItem(
      title: "JRMSU K Sports Fest 2026 — Shirt Design I",
      description:
          'Official shirt design for JRMSU K Sports Fest 2026, created using Adobe Photoshop and Illustrator.',
      imagePath: 'assets/images/projects/design1.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
    ),
    ProjectItem(
      title: "JRMSU K Sports Fest 2026 — Shirt Design II",
      description:
          'Second variant of the official shirt design for JRMSU K Sports Fest 2026.',
      imagePath: 'assets/images/projects/design2.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
    ),
    ProjectItem(
      title: "JRMSU K Sports Fest 2026 — Basketball Jersey Design",
      description:
          'Third variant of the official shirt design for JRMSU K Sports Fest 2026.',
      imagePath: 'assets/images/projects/design3.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
    ),
  ];
}
