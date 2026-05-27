class EducationEntry {
  final String degree;
  final String school;
  final String period;
  final String? description;
  final String? logoPath;

  const EducationEntry({
    required this.degree,
    required this.school,
    required this.period,
    this.description,
    this.logoPath,
  });
}
