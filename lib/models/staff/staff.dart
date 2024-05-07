import 'package:json_annotation/json_annotation.dart';
import 'package:schedule_app/models/role/role.dart';

part 'staff.g.dart';

@JsonSerializable(includeIfNull: false)
class Staff {
  int? uid;
  String? name;
  String? surname;
  String? emailAddress;
  String? contactNum;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  bool? isAdmin;
  Set<Role>? roles;

  Staff({
    this.name,
    this.surname,
    this.emailAddress,
    this.contactNum,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.isAdmin,
    this.roles,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);
}
