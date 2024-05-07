import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:schedule_app/api/api_url.dart';
import 'package:schedule_app/models/appointment/appointment_schadule.dart';
import 'package:schedule_app/models/course/course.dart';
import 'package:schedule_app/models/role/role.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/models/student/student.dart';
import 'package:schedule_app/models/subject/subject.dart';
import 'package:schedule_app/payload/loginrequest/login_request.dart';
import 'package:schedule_app/util/custom_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

part 'session_context.g.dart';

class SessionContext = SessionContextBase with _$SessionContext;

abstract class SessionContextBase with Store {
  @observable
  bool isloginLoading = false;

  @observable
  DateTime? selectedDateTime;
  @observable
  DateTime? startDateTime;
  @observable
  DateTime? endDateTime;
  @observable
  List<AppointmentSchadule> appointmentSchadules = [];
  @observable
  List<Appointment> appointments = [];
  @observable
  Staff? staff;
  @observable
  Subject? subject;
  @observable
  String? leftTimeValue, rightTimeValue;

  @observable
  List<Staff> staffList = [];
  @observable
  List<Student> students = [];

  @observable
  List<Subject> subjects = [];
  @observable
  List<Course> courses = [];
  Set<Role> roles = {};

  @observable
  Course? course;

  @action
  void setSelectedDateTime(DateTime selectedDate) {
    selectedDateTime = selectedDate;
  }

  @action
  void updateEndDate({required DateTime startDate, required DateTime endDate}) {
    if (startDate.year > endDate.year ||
        startDate.month > endDate.month ||
        startDate.day > endDate.day) {
      endDateTime = startDate;
    }
  }

  @action
  void addAppointment({required Appointment appointment}) {
    appointments.add(appointment);
  }

  @action
  void selectedStaff({required Staff selectedStaff}) {
    staff = selectedStaff;
  }

  @action
  void selectedSubject({required Subject selectedSubject}) {
    subject = selectedSubject;
  }

  @action
  void selectedCourse({required Course selectedCourse}) {
    course = selectedCourse;
  }

  @action
  void setTimeValue({required String value, required bool isLeft}) {
    if (isLeft) {
      leftTimeValue = value;
    } else {
      rightTimeValue = value;
    }
  }

  //--------------------------------Start staff functions---------------------

  @action
  Future<void> login({
    required BuildContext context,
    required LoginRequest loginRequest,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.post(
        Uri.parse('${ApiUrl.url}/authorized'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginRequest),
      );
      final staus = jsonDecode(response.body)['status'] as int;

      if (staus == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;

        debugPrint('$json');

        staff = Staff.fromJson(json);
      } else {
        debugPrint('$staus');
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Invalid email address or password',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
      isloginLoading = false;
    }
  }

  @action
  Future<void> updateAuthorization({
    required BuildContext context,
    required LoginRequest loginRequest,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(
          Uri.parse('${ApiUrl.url}/update/authorized'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(loginRequest));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;

        final tempStuff = Staff.fromJson(json);

        for (int index = 0; index < staffList.length; index++) {
          if (staffList[index].uid == tempStuff.uid) {
            staffList.insert(index, tempStuff);
          }
        }
      }
    } on Exception catch (e) {
      debugPrint('$e');
      isloginLoading = false;
    }
  }

  @action
  void logout() {
    staff = null;
  }

  @action
  Future<void> createStaff({
    required BuildContext context,
    required Staff staff,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.post(Uri.parse('${ApiUrl.url}/create/staff'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(staff));
      final status = jsonDecode(response.body)['status'] as int;

      if (status == 201) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        staffList.add(Staff.fromJson(json));
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Lecture is successfully added',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Lecture is not successfully added,\nPlease try again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
      isloginLoading = false;
    }
  }

  @action
  Future<void> updateStaff({
    required BuildContext context,
    required Staff staff,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(
          Uri.parse('${ApiUrl.url}/update/staff/${staff.uid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(staff));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;

        final tempStuff = Staff.fromJson(json);

        for (int index = 0; index < staffList.length; index++) {
          if (staffList[index].uid == tempStuff.uid) {
            staffList.insert(index, tempStuff);
          }
        }
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Lecture is successfully updated',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Lecture is not successfully updated,\npPlease tray again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> deleteStaff({
    required BuildContext context,
    required Staff staff,
  }) async {
    isloginLoading = true;
    try {
      final response = http.delete(
          Uri.parse('${ApiUrl.url}/delete/staff/${staff.uid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      response.then((value) {
        if (value.statusCode == 200) {
          debugPrint('value $value');
          staffList.remove(staff);

          toast(
            context: context,
            color: CustomColor.primaryColors.withOpacity(0.70),
            text: 'Lecture is successfully deleted',
          );
        } else {
          toast(
            context: context,
            color: Colors.deepOrange,
            text: 'Lecture is not successfully deleted,\nPlease try again',
          );
        }
      }).catchError((error) {
        debugPrint('$error');
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Lecture is not successfully deleted,\nPlease try again',
        );
      });
    } on Exception catch (e) {
      debugPrint('$e');
      isloginLoading = false;
    }
    isloginLoading = false;
  }

  @action
  Future<void> retrieveStaff() async {
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.url}/retrieve/staffs'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      int statusCode = jsonDecode(response.body)['status'];
      if (response.body.isNotEmpty && statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;

        Iterable iterable = json;
        staffList = List<Staff>.from(
          iterable.map(
            (model) => Staff.fromJson(model),
          ),
        );
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> assignCourse({
    required BuildContext context,
    required Staff staff,
    required Course course,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(
        Uri.parse('${ApiUrl.url}/assign/course/${staff.uid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(course),
      );

      int statusCode = jsonDecode(response.body)['status'];
      if (response.body.isNotEmpty && statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        debugPrint('json $json');
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text:
              'Course is successfully assigned to lecture ${staff.name!} ${staff.surname!}',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Course is not successfully assigned,\n please try again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  //--------------------------------End staff functions-------------------------

  //--------------------------------Start Subject functions---------------------

  @action
  void removeSunjectfromList({required Subject subject}) {
    subjects.remove(subject);
  }

  @action
  Future<void> retrieveSubjects() async {
    isloginLoading = true;
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.url}/retrieve/subject'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      int statusCode = jsonDecode(response.body)['status'];
      if (response.body.isNotEmpty && statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;

        Iterable iterable = json;
        subjects = List<Subject>.from(
          iterable.map(
            (model) => Subject.fromJson(model),
          ),
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> createSubject({
    required BuildContext context,
    required Subject subject,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.post(
          Uri.parse('${ApiUrl.url}/create/subject'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(subject));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 201) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        subjects.add(Subject.fromJson(json));
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Subject is successfully created',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Subject is not successfully created,\nPlease try again',
        );
      }

      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> updateSubject({
    required BuildContext context,
    required Subject subject,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(
          Uri.parse('${ApiUrl.url}/update/subject/${subject.sid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(subject));
      final status = jsonDecode(response.body)['status'] as int;

      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        final tempStaff = Subject.fromJson(json);
        for (int index = 0; index < subjects.length; index++) {
          if (subjects[index].sid == tempStaff.sid) {
            subjects.insert(index, tempStaff);
          }
        }
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Subject is successfully updated',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Subject is not successfully created,\nPlease try again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> deleteSubject({
    required BuildContext context,
    required Subject subject,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.delete(
        Uri.parse('${ApiUrl.url}/delete/subject/${subject.sid}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        subjects.remove(subject);
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Subject is successfully deleted',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Subject is not successfully deleted,\nPlease try again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  //--------------------------------End subject functions-----------------------
  //--------------------------------Start course functions----------------------

  @action
  Future<void> createCourse({
    required BuildContext context,
    required Course course,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.post(Uri.parse('${ApiUrl.url}/create/course'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(course));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        courses.add(Course.fromJson(json));
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Course is successfully created',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Course is not successfully created',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> retrieveCourses() async {
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.url}/retrieve/courses'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      var statusCode = jsonDecode(response.body)['status'] as int;
      if (response.body.isNotEmpty && statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;
        Iterable iterable = json;
        if (iterable.isNotEmpty) {
          courses = List<Course>.from(
            iterable.map(
              (model) => Course.fromJson(model),
            ),
          );
        }
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  @action
  Future<void> assignsubject({
    required BuildContext context,
    required Course course,
    required Subject subject,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(
          Uri.parse('${ApiUrl.url}/assign/subject/${course.cid}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(subject));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        final tempCourse = Course.fromJson(json);

        for (int index = 0; index < subjects.length; index++) {
          if (courses[index].cid == tempCourse.cid) {
            courses.insert(index, tempCourse);
          }
        }
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text:
              'Subject is successfully assigned to Course name ${course.courseName}',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text:
              'Subject is not successfully assigned to Course name ${course.courseName}',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  //--------------------------------End course functions----------------------

  @action
  Future<void> retrieveRoles() async {
    isloginLoading = true;
    try {
      final response = await http.get(Uri.parse('${ApiUrl.url}/retrieve/roles'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      int statusCode = jsonDecode(response.body)['status'];
      if (response.body.isNotEmpty && statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;
        Iterable iterable = json;
        roles = Set<Role>.from(iterable.map((model) => Role.fromJson(model)));
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
      isloginLoading = false;
    }
  }

  //--------------------------------End course functions----------------------
  //--------------------------------Start Appoitment functions----------------------

  @action
  Future<void> retrieveAppointment() async {
    isloginLoading = true;
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.url}/retrieve/schedule'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      if (response.body.isNotEmpty &&
          jsonDecode(response.body)['status'] == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;
        Iterable iterable = json;
        appointmentSchadules = List<AppointmentSchadule>.from(
          iterable.map(
            (model) => AppointmentSchadule.fromJson(model),
          ),
        );

        for (var appointmentSchedule in appointmentSchadules) {
          appointments.add(Appointment(
            startTime: appointmentSchedule.startTime,
            endTime: appointmentSchedule.endTime,
            notes: appointmentSchedule.notes,
            subject:
                '${appointmentSchedule.subject.subjectName!} \n${appointmentSchedule.staff.name} ${appointmentSchedule.staff.surname!}',
            color: CustomColor.primaryColors,
          ));
        }
        debugPrint('${appointments.toList()}');
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
    isloginLoading = false;
  }

  @action
  Future<void> createAppointment({
    required BuildContext context,
    required AppointmentSchadule appointment,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.post(
          Uri.parse('${ApiUrl.url}/create/schedule'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(appointment));
      int statusCode = jsonDecode(response.body)['status'] as int;
      if (statusCode == 201) {
        if (response.body.isNotEmpty && statusCode == 200) {
          final json =
              jsonDecode(response.body)['data'] as Map<String, dynamic>;
          appointmentSchadules.add(AppointmentSchadule.fromJson(json));
        }
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text:
              'Appointment successfully created for Lecture ${appointment.staff.name!} ${appointment.staff.surname}',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Appointment is not successfully created',
        );
      }
    } on Exception catch (e) {
      debugPrint('$e');
    }
    isloginLoading = false;
  }

  //--------------------------------End Appoitment functions----------------------

  //--------------------------------Start Student functions----------------------

  @action
  Future<void> createStudentRecord({
    required BuildContext context,
    required Student student,
  }) async {
    isloginLoading = true;

    try {
      final response = await http.post(
          Uri.parse('${ApiUrl.url}/create/student'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(student));
      final status = jsonDecode(response.body)['status'] as int;

      if (status == 201) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;
        students.add(Student.fromJson(json));
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Student record is successfully added',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Student record is not successfully added,\nPlease try again',
        );
      }
      isloginLoading = false;
    } on Exception catch (e) {
      isloginLoading = false;
      debugPrint('$e');
    }
  }

  @action
  Future<void> updateStudentRecord({
    required BuildContext context,
    required Student student,
  }) async {
    isloginLoading = true;
    try {
      final response = await http.put(Uri.parse('${ApiUrl.url}/update/student'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(student));
      final status = jsonDecode(response.body)['status'] as int;
      if (status == 200) {
        final json = jsonDecode(response.body)['data'] as Map<String, dynamic>;

        final tempStudent = Student.fromJson(json);
        for (var index = 0; index < students.length; index++) {
          if (students[index].studentId == tempStudent.studentId) {
            students.insert(index, tempStudent);
          }
        }
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Student record is successfully updated',
        );
      } else {
        // ignore: use_build_context_synchronously
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text:
              'Student record is not successfully updated,\npPlease tray again',
        );
      }
    } on Exception catch (e) {
      isloginLoading = false;
      debugPrint('$e');
    }
  }

  @action
  Future<void> deleteStudentRecord({
    required BuildContext context,
    required Student student,
  }) async {
    isloginLoading = true;
    final response = http.delete(
        Uri.parse('${ApiUrl.url}/delete/student/${student.studentId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        });
    response.then((value) {
      if (value.statusCode == 200) {
        debugPrint('value $value');
        staffList.remove(staff);
        toast(
          context: context,
          color: CustomColor.primaryColors.withOpacity(0.70),
          text: 'Student record is successfully deleted',
        );
      } else {
        toast(
          context: context,
          color: Colors.deepOrange,
          text: 'Student record is not successfully deleted,\nPlease try again',
        );
      }
    }).catchError((onError) {
      debugPrint('$onError');
      toast(
        context: context,
        color: Colors.deepOrange,
        text: 'Unknow error please try again',
      );
    });
  }

  @action
  Future<void> retrieveStudent() async {
    isloginLoading = true;
    try {
      final response = await http.get(
          Uri.parse('${ApiUrl.url}/retrieve/students'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      int statusCode = jsonDecode(response.body)['status'] as int;

      if (statusCode == 200) {
        final json = jsonDecode(response.body)['data'] as Iterable;
        Iterable iterable = json;
        students = List<Student>.from(
          iterable.map(
            (model) => Student.fromJson(model),
          ),
        );
        isloginLoading = false;
      }
      isloginLoading = false;
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  //--------------------------------End Student functions----------------------

  //CustomColor.primaryColors.withOpacity(0.70)

  Future<void> toast({
    required BuildContext context,
    required String text,
    required Color color,
  }) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: color,
      ),
    );
  }
}
