// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_context.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SessionContext on SessionContextBase, Store {
  late final _$isloginLoadingAtom =
      Atom(name: 'SessionContextBase.isloginLoading', context: context);

  @override
  bool get isloginLoading {
    _$isloginLoadingAtom.reportRead();
    return super.isloginLoading;
  }

  @override
  set isloginLoading(bool value) {
    _$isloginLoadingAtom.reportWrite(value, super.isloginLoading, () {
      super.isloginLoading = value;
    });
  }

  late final _$selectedDateTimeAtom =
      Atom(name: 'SessionContextBase.selectedDateTime', context: context);

  @override
  DateTime? get selectedDateTime {
    _$selectedDateTimeAtom.reportRead();
    return super.selectedDateTime;
  }

  @override
  set selectedDateTime(DateTime? value) {
    _$selectedDateTimeAtom.reportWrite(value, super.selectedDateTime, () {
      super.selectedDateTime = value;
    });
  }

  late final _$startDateTimeAtom =
      Atom(name: 'SessionContextBase.startDateTime', context: context);

  @override
  DateTime? get startDateTime {
    _$startDateTimeAtom.reportRead();
    return super.startDateTime;
  }

  @override
  set startDateTime(DateTime? value) {
    _$startDateTimeAtom.reportWrite(value, super.startDateTime, () {
      super.startDateTime = value;
    });
  }

  late final _$endDateTimeAtom =
      Atom(name: 'SessionContextBase.endDateTime', context: context);

  @override
  DateTime? get endDateTime {
    _$endDateTimeAtom.reportRead();
    return super.endDateTime;
  }

  @override
  set endDateTime(DateTime? value) {
    _$endDateTimeAtom.reportWrite(value, super.endDateTime, () {
      super.endDateTime = value;
    });
  }

  late final _$appointmentSchadulesAtom =
      Atom(name: 'SessionContextBase.appointmentSchadules', context: context);

  @override
  List<AppointmentSchadule> get appointmentSchadules {
    _$appointmentSchadulesAtom.reportRead();
    return super.appointmentSchadules;
  }

  @override
  set appointmentSchadules(List<AppointmentSchadule> value) {
    _$appointmentSchadulesAtom.reportWrite(value, super.appointmentSchadules,
        () {
      super.appointmentSchadules = value;
    });
  }

  late final _$appointmentsAtom =
      Atom(name: 'SessionContextBase.appointments', context: context);

  @override
  List<Appointment> get appointments {
    _$appointmentsAtom.reportRead();
    return super.appointments;
  }

  @override
  set appointments(List<Appointment> value) {
    _$appointmentsAtom.reportWrite(value, super.appointments, () {
      super.appointments = value;
    });
  }

  late final _$staffAtom =
      Atom(name: 'SessionContextBase.staff', context: context);

  @override
  Staff? get staff {
    _$staffAtom.reportRead();
    return super.staff;
  }

  @override
  set staff(Staff? value) {
    _$staffAtom.reportWrite(value, super.staff, () {
      super.staff = value;
    });
  }

  late final _$subjectAtom =
      Atom(name: 'SessionContextBase.subject', context: context);

  @override
  Subject? get subject {
    _$subjectAtom.reportRead();
    return super.subject;
  }

  @override
  set subject(Subject? value) {
    _$subjectAtom.reportWrite(value, super.subject, () {
      super.subject = value;
    });
  }

  late final _$leftTimeValueAtom =
      Atom(name: 'SessionContextBase.leftTimeValue', context: context);

  @override
  String? get leftTimeValue {
    _$leftTimeValueAtom.reportRead();
    return super.leftTimeValue;
  }

  @override
  set leftTimeValue(String? value) {
    _$leftTimeValueAtom.reportWrite(value, super.leftTimeValue, () {
      super.leftTimeValue = value;
    });
  }

  late final _$rightTimeValueAtom =
      Atom(name: 'SessionContextBase.rightTimeValue', context: context);

  @override
  String? get rightTimeValue {
    _$rightTimeValueAtom.reportRead();
    return super.rightTimeValue;
  }

  @override
  set rightTimeValue(String? value) {
    _$rightTimeValueAtom.reportWrite(value, super.rightTimeValue, () {
      super.rightTimeValue = value;
    });
  }

  late final _$staffListAtom =
      Atom(name: 'SessionContextBase.staffList', context: context);

  @override
  List<Staff> get staffList {
    _$staffListAtom.reportRead();
    return super.staffList;
  }

  @override
  set staffList(List<Staff> value) {
    _$staffListAtom.reportWrite(value, super.staffList, () {
      super.staffList = value;
    });
  }

  late final _$studentsAtom =
      Atom(name: 'SessionContextBase.students', context: context);

  @override
  List<Student> get students {
    _$studentsAtom.reportRead();
    return super.students;
  }

  @override
  set students(List<Student> value) {
    _$studentsAtom.reportWrite(value, super.students, () {
      super.students = value;
    });
  }

  late final _$subjectsAtom =
      Atom(name: 'SessionContextBase.subjects', context: context);

  @override
  List<Subject> get subjects {
    _$subjectsAtom.reportRead();
    return super.subjects;
  }

  @override
  set subjects(List<Subject> value) {
    _$subjectsAtom.reportWrite(value, super.subjects, () {
      super.subjects = value;
    });
  }

  late final _$coursesAtom =
      Atom(name: 'SessionContextBase.courses', context: context);

  @override
  List<Course> get courses {
    _$coursesAtom.reportRead();
    return super.courses;
  }

  @override
  set courses(List<Course> value) {
    _$coursesAtom.reportWrite(value, super.courses, () {
      super.courses = value;
    });
  }

  late final _$courseAtom =
      Atom(name: 'SessionContextBase.course', context: context);

  @override
  Course? get course {
    _$courseAtom.reportRead();
    return super.course;
  }

  @override
  set course(Course? value) {
    _$courseAtom.reportWrite(value, super.course, () {
      super.course = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('SessionContextBase.login', context: context);

  @override
  Future<void> login(
      {required BuildContext context, required LoginRequest loginRequest}) {
    return _$loginAsyncAction
        .run(() => super.login(context: context, loginRequest: loginRequest));
  }

  late final _$updateAuthorizationAsyncAction =
      AsyncAction('SessionContextBase.updateAuthorization', context: context);

  @override
  Future<void> updateAuthorization(
      {required BuildContext context, required LoginRequest loginRequest}) {
    return _$updateAuthorizationAsyncAction.run(() => super
        .updateAuthorization(context: context, loginRequest: loginRequest));
  }

  late final _$createStaffAsyncAction =
      AsyncAction('SessionContextBase.createStaff', context: context);

  @override
  Future<void> createStaff(
      {required BuildContext context, required Staff staff}) {
    return _$createStaffAsyncAction
        .run(() => super.createStaff(context: context, staff: staff));
  }

  late final _$updateStaffAsyncAction =
      AsyncAction('SessionContextBase.updateStaff', context: context);

  @override
  Future<void> updateStaff(
      {required BuildContext context, required Staff staff}) {
    return _$updateStaffAsyncAction
        .run(() => super.updateStaff(context: context, staff: staff));
  }

  late final _$deleteStaffAsyncAction =
      AsyncAction('SessionContextBase.deleteStaff', context: context);

  @override
  Future<void> deleteStaff(
      {required BuildContext context, required Staff staff}) {
    return _$deleteStaffAsyncAction
        .run(() => super.deleteStaff(context: context, staff: staff));
  }

  late final _$retrieveStaffAsyncAction =
      AsyncAction('SessionContextBase.retrieveStaff', context: context);

  @override
  Future<void> retrieveStaff() {
    return _$retrieveStaffAsyncAction.run(() => super.retrieveStaff());
  }

  late final _$retrieveSubjectsAsyncAction =
      AsyncAction('SessionContextBase.retrieveSubjects', context: context);

  @override
  Future<void> retrieveSubjects() {
    return _$retrieveSubjectsAsyncAction.run(() => super.retrieveSubjects());
  }

  late final _$createSubjectAsyncAction =
      AsyncAction('SessionContextBase.createSubject', context: context);

  @override
  Future<void> createSubject(
      {required BuildContext context, required Subject subject}) {
    return _$createSubjectAsyncAction
        .run(() => super.createSubject(context: context, subject: subject));
  }

  late final _$updateSubjectAsyncAction =
      AsyncAction('SessionContextBase.updateSubject', context: context);

  @override
  Future<void> updateSubject(
      {required BuildContext context, required Subject subject}) {
    return _$updateSubjectAsyncAction
        .run(() => super.updateSubject(context: context, subject: subject));
  }

  late final _$deleteSubjectAsyncAction =
      AsyncAction('SessionContextBase.deleteSubject', context: context);

  @override
  Future<void> deleteSubject(
      {required BuildContext context, required Subject subject}) {
    return _$deleteSubjectAsyncAction
        .run(() => super.deleteSubject(context: context, subject: subject));
  }

  late final _$createCourseAsyncAction =
      AsyncAction('SessionContextBase.createCourse', context: context);

  @override
  Future<void> createCourse(
      {required BuildContext context, required Course course}) {
    return _$createCourseAsyncAction
        .run(() => super.createCourse(context: context, course: course));
  }

  late final _$retrieveCoursesAsyncAction =
      AsyncAction('SessionContextBase.retrieveCourses', context: context);

  @override
  Future<void> retrieveCourses() {
    return _$retrieveCoursesAsyncAction.run(() => super.retrieveCourses());
  }

  late final _$assignsubjectAsyncAction =
      AsyncAction('SessionContextBase.assignsubject', context: context);

  @override
  Future<void> assignsubject(
      {required BuildContext context,
      required Course course,
      required Subject subject}) {
    return _$assignsubjectAsyncAction.run(() => super
        .assignsubject(context: context, course: course, subject: subject));
  }

  late final _$retrieveRolesAsyncAction =
      AsyncAction('SessionContextBase.retrieveRoles', context: context);

  @override
  Future<void> retrieveRoles() {
    return _$retrieveRolesAsyncAction.run(() => super.retrieveRoles());
  }

  late final _$retrieveAppointmentAsyncAction =
      AsyncAction('SessionContextBase.retrieveAppointment', context: context);

  @override
  Future<void> retrieveAppointment() {
    return _$retrieveAppointmentAsyncAction
        .run(() => super.retrieveAppointment());
  }

  late final _$createAppointmentAsyncAction =
      AsyncAction('SessionContextBase.createAppointment', context: context);

  @override
  Future<void> createAppointment(
      {required BuildContext context,
      required AppointmentSchadule appointment}) {
    return _$createAppointmentAsyncAction.run(() =>
        super.createAppointment(context: context, appointment: appointment));
  }

  late final _$createStudentRecordAsyncAction =
      AsyncAction('SessionContextBase.createStudentRecord', context: context);

  @override
  Future<void> createStudentRecord(
      {required BuildContext context, required Student student}) {
    return _$createStudentRecordAsyncAction.run(
        () => super.createStudentRecord(context: context, student: student));
  }

  late final _$updateStudentRecordAsyncAction =
      AsyncAction('SessionContextBase.updateStudentRecord', context: context);

  @override
  Future<void> updateStudentRecord(
      {required BuildContext context, required Student student}) {
    return _$updateStudentRecordAsyncAction.run(
        () => super.updateStudentRecord(context: context, student: student));
  }

  late final _$deleteStudentRecordAsyncAction =
      AsyncAction('SessionContextBase.deleteStudentRecord', context: context);

  @override
  Future<void> deleteStudentRecord(
      {required BuildContext context, required Student student}) {
    return _$deleteStudentRecordAsyncAction.run(
        () => super.deleteStudentRecord(context: context, student: student));
  }

  late final _$retrieveStudentAsyncAction =
      AsyncAction('SessionContextBase.retrieveStudent', context: context);

  @override
  Future<void> retrieveStudent() {
    return _$retrieveStudentAsyncAction.run(() => super.retrieveStudent());
  }

  late final _$SessionContextBaseActionController =
      ActionController(name: 'SessionContextBase', context: context);

  @override
  void setSelectedDateTime(DateTime selectedDate) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.setSelectedDateTime');
    try {
      return super.setSelectedDateTime(selectedDate);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateEndDate({required DateTime startDate, required DateTime endDate}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.updateEndDate');
    try {
      return super.updateEndDate(startDate: startDate, endDate: endDate);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAppointment({required Appointment appointment}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.addAppointment');
    try {
      return super.addAppointment(appointment: appointment);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedStaff({required Staff selectedStaff}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.selectedStaff');
    try {
      return super.selectedStaff(selectedStaff: selectedStaff);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedSubject({required Subject selectedSubject}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.selectedSubject');
    try {
      return super.selectedSubject(selectedSubject: selectedSubject);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectedCourse({required Course selectedCourse}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.selectedCourse');
    try {
      return super.selectedCourse(selectedCourse: selectedCourse);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTimeValue({required String value, required bool isLeft}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.setTimeValue');
    try {
      return super.setTimeValue(value: value, isLeft: isLeft);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.logout');
    try {
      return super.logout();
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSunjectfromList({required Subject subject}) {
    final _$actionInfo = _$SessionContextBaseActionController.startAction(
        name: 'SessionContextBase.removeSunjectfromList');
    try {
      return super.removeSunjectfromList(subject: subject);
    } finally {
      _$SessionContextBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isloginLoading: ${isloginLoading},
selectedDateTime: ${selectedDateTime},
startDateTime: ${startDateTime},
endDateTime: ${endDateTime},
appointmentSchadules: ${appointmentSchadules},
appointments: ${appointments},
staff: ${staff},
subject: ${subject},
leftTimeValue: ${leftTimeValue},
rightTimeValue: ${rightTimeValue},
staffList: ${staffList},
students: ${students},
subjects: ${subjects},
courses: ${courses},
course: ${course}
    ''';
  }
}
