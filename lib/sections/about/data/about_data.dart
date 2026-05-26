import 'package:flutter/material.dart';
import 'package:jcgpl_portfolio/sections/about/models/education.dart';
import 'package:jcgpl_portfolio/sections/about/models/personal.dart';
import 'package:jcgpl_portfolio/sections/about/models/stat.dart';

class AboutData {
  static final List<EducationEntry> education = [
    EducationEntry(
      degree: "Bachelor of Science in Computer Science",
      school: "JRMSU Katipunan Campus",
      period: "2022 - Present",
      description:
          "Focused on software engineering, mobile development, and systems design.",
    ),
    EducationEntry(
      degree: "Senior High School — TVL (CSS)",
      school: "Cogon National High School",
      period: "2020 - 2022",
      description:
          "Technical-Vocational-Livelihood track - Computer Systems Servicing.",
    ),
    EducationEntry(
      degree: "Junior High School",
      school: "Cogon National High School",
      period: "2016 - 2020",
    ),
    EducationEntry(
      degree: "Primary School",
      school: "Cayasan Elementary School",
      period: "2010 - 2016",
    ),
  ];

  static final List<PersonalDetail> details = [
    PersonalDetail(icon: Icons.cake_rounded, label: "Age", value: "21"),
    PersonalDetail(
      icon: Icons.location_on_rounded,
      label: "Location",
      value: "Philippines",
    ),
    PersonalDetail(
      icon: Icons.email_rounded,
      label: "Email",
      value: "gapoljesie23@email.com",
    ),
  ];

  static final List<StatItem> stats = [
    StatItem(count: "10+", label: "Projects"),
    StatItem(count: "3+", label: "Years Exp."),
    StatItem(count: "5+", label: "Clients"),
  ];
}
