import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  int? studentId;
  String? name;
  String? surname;
  String? emailAddress;
  String? contactNum;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;

  Student({
    this.name,
    this.surname,
    this.emailAddress,
    this.contactNum,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
