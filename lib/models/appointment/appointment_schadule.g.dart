// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schadule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentSchadule _$AppointmentSchaduleFromJson(Map<String, dynamic> json) =>
    AppointmentSchadule(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      staff: Staff.fromJson(json['staff'] as Map<String, dynamic>),
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      status: json['status'] as int,
      notes: json['notes'] as String,
    )..aid = json['aid'] as int?;

Map<String, dynamic> _$AppointmentSchaduleToJson(AppointmentSchadule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('aid', instance.aid);
  val['startTime'] = instance.startTime.toIso8601String();
  val['endTime'] = instance.endTime.toIso8601String();
  val['staff'] = instance.staff;
  val['subject'] = instance.subject;
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['updatedAt'] = instance.updatedAt.toIso8601String();
  val['status'] = instance.status;
  val['notes'] = instance.notes;
  return val;
}
