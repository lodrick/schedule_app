import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  int? sid;
  String? subjectName;
  String? description;
  String? subjectCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isAssigned;
  int? status;

  Subject({
    this.subjectName,
    this.description,
    this.subjectCode,
    this.createdAt,
    this.updatedAt,
    this.isAssigned,
    this.status,
  });

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
