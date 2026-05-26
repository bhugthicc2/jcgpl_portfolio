import 'package:jcgpl_portfolio/sections/projects/projects_section.dart';

class ProjectsData {
  static final List<ProjectItem> projects = [
    ProjectItem(
      title: 'Cloud-based Vehicle Monitoring System',
      description:
          'A Flutter-based vehicle monitoring system using QR codes and Firebase Firestore for real-time tracking and AES-encrypted payloads.',
      imagePath: 'assets/images/projects/cvms.png',
      techStack: ['Flutter', 'Firebase', 'AES', 'Firestore'],
      status: ProjectStatus.completed,
    ),
    ProjectItem(
      title: 'JRMSU CCS QR-based Visitors Log System',
      //todo
      description:
          'A neumorphic personal portfolio built with Flutter Web, featuring responsive layout and smooth scroll navigation.',
      imagePath: 'assets/images/projects/visitors_log.png',
      techStack: ['Flutter', 'Dart', 'Firebase'],
      status: ProjectStatus.completed,
    ),
    ProjectItem(
      title: 'Gapz Graphics Portfolio Website',
      description:
          'A reusable Flutter starter kit with Firebase Auth, Firestore rules, and role-based access control out of the box.',
      imagePath: 'assets/images/projects/gapz_graphix.png',
      techStack: ['HTML', 'CSS', 'Javascript'],
      status: ProjectStatus.completed,
    ),
    ProjectItem(
      title: 'JRMSU - K Sports\'s Fest 2026 Shirt Design',
      description:
          'Mobile inventory tracker with barcode scanning, SQL local storage, and REST API sync for small businesses.',
      imagePath: 'assets/images/projects/design1.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
      status: ProjectStatus.completed,
    ),
    ProjectItem(
      title: 'JRMSU - K Sports\'s Fest 2026 Shirt Design',
      description:
          'Mobile inventory tracker with barcode scanning, SQL local storage, and REST API sync for small businesses.',
      imagePath: 'assets/images/projects/design2.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
      status: ProjectStatus.completed,
    ),
    ProjectItem(
      title: 'JRMSU - K Sports\'s Fest 2026 Shirt Design',
      description:
          'Mobile inventory tracker with barcode scanning, SQL local storage, and REST API sync for small businesses.',
      imagePath: 'assets/images/projects/design3.png',
      techStack: ['Adobe Photoshop', 'Adobe Illustrator'],
      status: ProjectStatus.completed,
    ),
  ];
}
