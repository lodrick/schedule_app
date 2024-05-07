// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      emailAddress: json['emailAddress'] as String?,
      contactNum: json['contactNum'] as String?,
      password: json['password'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as int?,
    )..studentId = json['studentId'] as int?;

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentId': instance.studentId,
      'name': instance.name,
      'surname': instance.surname,
      'emailAddress': instance.emailAddress,
      'contactNum': instance.contactNum,
      'password': instance.password,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
    };
