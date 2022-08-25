import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExplorePerson {
  const ExplorePerson({
    required this.name,
    required this.uid,
    required this.imageUrl,
    required this.experience,
    required this.educationFile,
    required this.experienceFile,
    required this.qualification,
    required this.specialisation,
    required this.universityName,
  });

  ExplorePerson.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          uid: json['uid'],
          imageUrl: json['imageUrl'],
          experience: json['experience'],
          educationFile: json['educationFile'],
          experienceFile: json['experienceFile'],
          qualification: json['qualification'],
          specialisation: json['specialisation'],
          universityName: json['universityName'],
        );
  final String uid;
  final String name;
  final String imageUrl;
  final String? experience;
  final String educationFile;
  final String? experienceFile;
  final String qualification;
  final String specialisation;
  final String universityName;
}
