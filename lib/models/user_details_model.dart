import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserDetailsModelOne {
  String role = "";
  String name = "";
  String email = "";
  int question = 0;
  UserDetailsModelOne({
    required this.role,
    required this.name,
    required this.email,
    required this.question,
  });

  UserDetailsModelOne copyWith({
    String? role,
    String? name,
    String? email,
    int? question,
  }) {
    return UserDetailsModelOne(
      role: role ?? this.role,
      name: name ?? this.name,
      email: email ?? this.email,
      question: question ?? this.question,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'name': name,
      'email': email,
      'question': question,
    };
  }

  factory UserDetailsModelOne.fromMap(Map<String, dynamic> map) {
    userDetailsModelOne.email = map['email'];
    userDetailsModelOne.role = map['role'];
    userDetailsModelOne.name = map['name'];
    userDetailsModelOne.question = map['question'];
    return UserDetailsModelOne(
      role: map['role'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      question: map['question']?.toInt() ?? 0,
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
    return 'UserDetailsModelOne(role: $role, name: $name, email: $email, question: $question)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetailsModelOne &&
        other.role == role &&
        other.name == name &&
        other.email == email &&
        other.question == question;
  }

  @override
  int get hashCode {
    return role.hashCode ^ name.hashCode ^ email.hashCode ^ question.hashCode;
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
