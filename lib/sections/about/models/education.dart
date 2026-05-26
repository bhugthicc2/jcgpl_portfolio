class EducationEntry {
  final String degree;
  final String school;
  final String period;
  final String? description;

  const EducationEntry({
    required this.degree,
    required this.school,
    required this.period,
    this.description,
  });
}
