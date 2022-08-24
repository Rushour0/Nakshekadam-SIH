class TestMarksDetails {
  double stem = 0.0;
  double commerce_management = 0.0;
  double creative_argumentative_studies = 0.0;
  double civil_services = 0.0;
  double defense = 0.0;
  double vocational_courses = 0.0;
  double jobs_as_soon_as_possible = 0.0;
  Map<String, double> personality_marks = {
    "stem": 0.0,
    "commerce & management": 0.0,
    "creative & argumentative studies": 0.0,
    "civil services": 0.0,
    "defense": 0.0,
    "vocational courses": 0.0,
    "jobs as soon as possible": 0.0,
  };
  Map<String, double> interest_test = {
    "stem": 0.0,
    "commerce & management": 0.0,
    "creative & argumentative studies": 0.0,
    "civil services": 0.0,
    "defense": 0.0,
    "vocational courses": 0.0,
    "jobs as soon as possible": 0.0,
  };
  Map<String, double> background_test = {
    "stem": 0.0,
    "commerce & management": 0.0,
    "creative & argumentative studies": 0.0,
    "civil services": 0.0,
    "defense": 0.0,
    "vocational courses": 0.0,
    "jobs as soon as possible": 0.0,
  };
  Map<String, double> aptitude_test = {
    "stem": 0.0,
    "commerce & management": 0.0,
    "creative & argumentative studies": 0.0,
    "civil services": 0.0,
    "defense": 0.0,
    "vocational courses": 0.0,
    "jobs as soon as possible": 0.0,
  };

  TestMarksDetails({
    required this.stem,
    required this.commerce_management,
    required this.creative_argumentative_studies,
    required this.civil_services,
    required this.defense,
    required this.vocational_courses,
    required this.jobs_as_soon_as_possible,
    required this.personality_marks,
  });

  static final testMarksDetails = TestMarksDetails._internal();
  TestMarksDetails._internal();

  factory TestMarksDetails.getModel() => testMarksDetails;
}
