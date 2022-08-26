import 'dart:convert';

class CollegeModel {
  String examinationSystem;
  int intake;
  String level;
  String department;
  String discipline;
  String faculty;
  String institute;
  String programme;
  CollegeModel({
    required this.examinationSystem,
    required this.intake,
    required this.level,
    required this.department,
    required this.discipline,
    required this.faculty,
    required this.institute,
    required this.programme,
  });

  CollegeModel copyWith({
    String? examinationSystem,
    int? intake,
    String? level,
    String? department,
    String? discipline,
    String? faculty,
    String? institute,
    String? programme,
  }) {
    return CollegeModel(
      examinationSystem: examinationSystem ?? this.examinationSystem,
      intake: intake ?? this.intake,
      level: level ?? this.level,
      department: department ?? this.department,
      discipline: discipline ?? this.discipline,
      faculty: faculty ?? this.faculty,
      institute: institute ?? this.institute,
      programme: programme ?? this.programme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Examination System': examinationSystem,
      'Intake': intake,
      'Level': level,
      'Name of Department': department,
      'Name of Discipline': discipline,
      'Name of Faculty': faculty,
      'Name of Institution': institute,
      'Programme': programme,
    };
  }

  factory CollegeModel.fromMap(Map<String, dynamic> map) {
    return CollegeModel(
      examinationSystem: map['Examination System'] ?? '',
      intake: map['Intake']?.toInt() ?? 0,
      level: map['Level'] ?? '',
      department: map['Name of Department'] ?? '',
      discipline: map['Name of Discipline'] ?? '',
      faculty: map['Name of Faculty'] ?? '',
      institute: map['Name of Institution'] ?? '',
      programme: map['Programme'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CollegeModel.fromJson(String source) =>
      CollegeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CollegeModel(examinationSystem: $examinationSystem, intake: $intake, level: $level, department: $department, discipline: $discipline, faculty: $faculty, institute: $institute, programme: $programme)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollegeModel &&
        other.examinationSystem == examinationSystem &&
        other.intake == intake &&
        other.level == level &&
        other.department == department &&
        other.discipline == discipline &&
        other.faculty == faculty &&
        other.institute == institute &&
        other.programme == programme;
  }

  @override
  int get hashCode {
    return examinationSystem.hashCode ^
        intake.hashCode ^
        level.hashCode ^
        department.hashCode ^
        discipline.hashCode ^
        faculty.hashCode ^
        institute.hashCode ^
        programme.hashCode;
  }
}
