class CumulativeMarks {
  double stem = 0.0;
  double commerce_management = 0.0;
  double creative_argumentative_studies = 0.0;
  double civil_services = 0.0;
  double defense = 0.0;
  double vocational_courses = 0.0;
  double jobs_as_soon_as_possible = 0.0;

  static final cumulativeMarks = CumulativeMarks._internal();
  CumulativeMarks._internal();

  factory CumulativeMarks.getModel() => cumulativeMarks;
}
