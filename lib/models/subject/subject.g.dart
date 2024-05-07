// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) => Subject(
      subjectName: json['subjectName'] as String?,
      description: json['description'] as String?,
      subjectCode: json['subjectCode'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isAssigned: json['isAssigned'] as bool?,
      status: json['status'] as int?,
    )..sid = json['sid'] as int?;

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'sid': instance.sid,
      'subjectName': instance.subjectName,
      'description': instance.description,
      'subjectCode': instance.subjectCode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isAssigned': instance.isAssigned,
      'status': instance.status,
    };
