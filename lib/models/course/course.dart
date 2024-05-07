import 'package:json_annotation/json_annotation.dart';
import 'package:schedule_app/models/subject/subject.dart';

part 'course.g.dart';

@JsonSerializable(includeIfNull: false)
class Course {
  int? cid;
  final String courseName;
  final String description;
  final String courseCode;
  final List<Subject> subjects;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;

  Course({
    required this.courseName,
    required this.description,
    required this.courseCode,
    required this.subjects,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
