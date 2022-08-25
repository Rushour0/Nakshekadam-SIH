import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserDetailsModelOne {
  String role = "";
  String name = "";
  String email = "";
  int question = 0;
  List<int> testGiven = [0, 0, 0, 0];
  bool under_3L = false;
  UserDetailsModelOne({
    required this.role,
    required this.name,
    required this.email,
    required this.question,
    required this.testGiven,
    required this.under_3L,
  });

  UserDetailsModelOne copyWith({
    String? role,
    String? name,
    String? email,
    int? question,
    List<int>? testGiven,
    bool? under_3L,
  }) {
    return UserDetailsModelOne(
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      question: question ?? this.question,
      testGiven: testGiven ?? this.testGiven,
      under_3L: under_3L ?? this.under_3L,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'name': name,
      'email': email,
      'question': question,
      'testGiven': testGiven,
      'under_3L': under_3L,
    };
  }

  UserDetailsModelOne.clear() {
    userDetailsModelOne.email = "";
    userDetailsModelOne.role = "";
    userDetailsModelOne.name = "";
    userDetailsModelOne.question = 0;
  }

  factory UserDetailsModelOne.fromMap(Map<String, dynamic> map) {
    userDetailsModelOne.email = map['email'];
    userDetailsModelOne.role = map['role'];
    userDetailsModelOne.name = map['name'];
    userDetailsModelOne.question = map['question'];
    userDetailsModelOne.testGiven = List<int>.from(map['testGiven']);
    userDetailsModelOne.under_3L = map['under_3L'];
    return UserDetailsModelOne(
      role: map['role'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      question: map['question']?.toInt() ?? 0,
      testGiven: List<int>.from(map['testGiven']),
      under_3L: map['under_3L'] ?? false,
    );
  }

  static final userDetailsModelOne = UserDetailsModelOne._internal();
  UserDetailsModelOne._internal();

  factory UserDetailsModelOne.getModel() => userDetailsModelOne;

  String toJson() => json.encode(toMap());

  factory UserDetailsModelOne.fromJson(String source) =>
      UserDetailsModelOne.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetailsModelOne(role: $role, name: $name, email: $email, question: $question, testGiven: $testGiven, under_3L: $under_3L)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetailsModelOne &&
        other.role == role &&
        other.name == name &&
        other.email == email &&
        other.question == question &&
        listEquals(other.testGiven, testGiven) &&
        other.under_3L == under_3L;
  }

  @override
  int get hashCode {
    return role.hashCode ^
        name.hashCode ^
        email.hashCode ^
        question.hashCode ^
        testGiven.hashCode ^
        under_3L.hashCode;
  }
}

class UserDetailsModelTwo {
  String grade = "";
  String marks = "";
  String schoolName = "";
  UserDetailsModelTwo({
    required this.grade,
    required this.marks,
    required this.schoolName,
  });

  UserDetailsModelTwo copyWith({
    String? grade,
    String? marks,
    String? numberOfSubjects,
    String? schoolName,
    String? question,
    List<String>? subjects,
    String? interestDomain,
  }) {
    return UserDetailsModelTwo(
      grade: grade ?? this.grade,
      marks: marks ?? this.marks,
      schoolName: schoolName ?? this.schoolName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'class/grade': grade,
      'marks/percentage': marks,
      'school/college name': schoolName,
    };
  }

  UserDetailsModelTwo.clear() {
    userDetailsModelTwo.grade = "";
    userDetailsModelTwo.marks = "";
    userDetailsModelTwo.schoolName = "";
  }

  factory UserDetailsModelTwo.fromMap(Map<String, dynamic> map) {
    userDetailsModelTwo.grade = map['class/grade'];
    userDetailsModelTwo.marks = map['marks/percentage'];
    userDetailsModelTwo.schoolName = map['school/college name'];
    return UserDetailsModelTwo(
      grade: map['class/grade'] ?? '',
      marks: map['marks/percentage'] ?? '',
      schoolName: map['school/college name'] ?? '',
    );
  }
  static final userDetailsModelTwo = UserDetailsModelTwo._internal();
  UserDetailsModelTwo._internal();

  factory UserDetailsModelTwo.getModel() => userDetailsModelTwo;

  String toJson() => json.encode(toMap());

  factory UserDetailsModelTwo.fromJson(String source) =>
      UserDetailsModelTwo.fromMap(json.decode(source));
}
