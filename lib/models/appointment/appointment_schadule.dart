import 'package:json_annotation/json_annotation.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/models/subject/subject.dart';

part 'appointment_schadule.g.dart';

@JsonSerializable(includeIfNull: false)
class AppointmentSchadule {
  int? aid;
  final DateTime startTime;
  final DateTime endTime;
  final Staff staff;
  final Subject subject;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final String notes;

  AppointmentSchadule({
    required this.startTime,
    required this.endTime,
    required this.staff,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.notes,
  });

  factory AppointmentSchadule.fromJson(Map<String, dynamic> json) =>
      _$AppointmentSchaduleFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentSchaduleToJson(this);
}
