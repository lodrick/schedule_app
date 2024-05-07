// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staff _$StaffFromJson(Map<String, dynamic> json) => Staff(
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
      isAdmin: json['isAdmin'] as bool?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toSet(),
    )..uid = json['uid'] as int?;

Map<String, dynamic> _$StaffToJson(Staff instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.uid);
  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('emailAddress', instance.emailAddress);
  writeNotNull('contactNum', instance.contactNum);
  writeNotNull('password', instance.password);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  writeNotNull('status', instance.status);
  writeNotNull('isAdmin', instance.isAdmin);
  writeNotNull('roles', instance.roles?.toList());
  return val;
}
