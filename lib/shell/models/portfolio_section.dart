enum PortfolioSection {
  landing,
  about,
  skills,
  projects,
  // experience,
  contact;

  String get label => switch (this) {
    PortfolioSection.landing => 'Home',
    PortfolioSection.about => 'About',
    PortfolioSection.skills => 'Skills',
    PortfolioSection.projects => 'Projects',
    // PortfolioSection.experience => 'Experience',
    PortfolioSection.contact => 'Contact',
  };

  // Pseudo-route used by TopNav's active indicator
  String get route => '/#$name';
}
