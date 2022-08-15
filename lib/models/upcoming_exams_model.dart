import 'dart:convert';

import 'package:intl/intl.dart';

class UpcomingExam {
  DateTime notifyDate;
  DateTime examDate;
  String examName;
  String examDomain;
  String examDescription;
  String link;

  UpcomingExam({
    required this.notifyDate,
    required this.examDate,
    required this.examName,
    required this.examDomain,
    required this.examDescription,
    required this.link,
  });


  UpcomingExam copyWith({
    DateTime? notifyDate,
    DateTime? examDate,
    String? examName,
    String? examDomain,
    String? examDescription,
    String? link,
  }) {
    return UpcomingExam(
      notifyDate: notifyDate ?? this.notifyDate,
      examDate: examDate ?? this.examDate,
      examName: examName ?? this.examName,
      examDomain: examDomain ?? this.examDomain,
      examDescription: examDescription ?? this.examDescription,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notifyDate': notifyDate.millisecondsSinceEpoch,
      'examDate': examDate.millisecondsSinceEpoch,
      'examName': examName,
      'examDomain': examDomain,
      'examDescription': examDescription,
      'link': link,
    };
  }

  factory UpcomingExam.fromMap(Map<String, dynamic> map) {
    return UpcomingExam(
      notifyDate: DateTime.parse(map['notifyDate']),
      examDate: DateTime.parse(map['examDate']),
      examName: map['examName'] ?? '',
      examDomain: map['examDomain'] ?? '',
      examDescription: map['examDescription'] ?? '',
      link: map['link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpcomingExam.fromJson(String source) => UpcomingExam.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpcomingExam(notifyDate: $notifyDate, examDate: $examDate, examName: $examName, examDomain: $examDomain, examDescription: $examDescription, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UpcomingExam &&
      other.notifyDate == notifyDate &&
      other.examDate == examDate &&
      other.examName == examName &&
      other.examDomain == examDomain &&
      other.examDescription == examDescription &&
      other.link == link;
  }

  @override
  int get hashCode {
    return notifyDate.hashCode ^
      examDate.hashCode ^
      examName.hashCode ^
      examDomain.hashCode ^
      examDescription.hashCode ^
      link.hashCode;
  }
}
