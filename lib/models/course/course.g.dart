// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      courseName: json['courseName'] as String,
      description: json['description'] as String,
      courseCode: json['courseCode'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => Subject.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as int,
    )..cid = json['cid'] as int?;

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cid', instance.cid);
  val['courseName'] = instance.courseName;
  val['description'] = instance.description;
  val['courseCode'] = instance.courseCode;
  val['subjects'] = instance.subjects;
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt.toIso8601String();
  val['status'] = instance.status;
  return val;
}
