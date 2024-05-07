import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/appointment/appointment_schadule.dart';
import 'package:schedule_app/screens/appointment/widgets/date_picker.dart';
import 'package:schedule_app/screens/appointment/widgets/search_staff.dart';
import 'package:schedule_app/screens/appointment/widgets/seatch_subject.dart';
import 'package:schedule_app/screens/appointment/widgets/time_picker.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  @override
  void initState() {
    super.initState();
  }

  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(
      builder: (_, sessionContext, __) {
        debugPrint('selected date ${sessionContext.selectedDateTime}');
        _startDateTime = sessionContext.selectedDateTime;
        _endDateTime = sessionContext.selectedDateTime;
        sessionContext.retrieveSubjects();
        sessionContext.retrieveStaff();
        return Observer(
          builder: (_) => LoaderHud(
            inAsyncCall: sessionContext.isloginLoading,
            loading: const CircularProgressIndicator(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  appBarView(sessionContext),
                  buildAppointment(
                    startDate: sessionContext.selectedDateTime!,
                    sessionContext: sessionContext,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget appBarView(SessionContext sessionContext) => SliverAppBar(
        expandedHeight: size!.height * 0.08,
        floating: true,
        pinned: true,
        backgroundColor: const Color.fromRGBO(238, 241, 248, 1),
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.height * 0.015,
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => createApointment(
                    sessionContext: sessionContext,
                  ),
                  child: const Text('Save'),
                ),
              ]),
        ),
      );

  Future<void> createApointment(
      {required SessionContext sessionContext}) async {
    debugPrint('Staff ${sessionContext.staff!.toJson()}');
    debugPrint('Subject ${sessionContext.subject!.toJson()}');
    debugPrint('left date $_startDateTime');
    debugPrint('left time ${sessionContext.leftTimeValue}');
    debugPrint('right date $_endDateTime');
    debugPrint('right time ${sessionContext.rightTimeValue}');
    debugPrint('notes ${_notesController.text}');

    final slitLeftTime = sessionContext.leftTimeValue!.split(':');
    final slitRightTime = sessionContext.rightTimeValue!.split(':');

    debugPrint(slitLeftTime[0].replaceAll('0', ''));

    DateTime aStartDate = DateTime(
      _startDateTime!.year,
      _startDateTime!.month,
      _startDateTime!.day,
      int.parse(slitLeftTime[0].replaceAll('0', '')),
      0,
      0,
    );
    DateTime aEnddate = DateTime(
      _endDateTime!.year,
      _endDateTime!.month,
      _endDateTime!.day,
      int.parse(slitRightTime[0].replaceAll('0', '')),
      0,
      0,
    );

    var appointmentSchadule = AppointmentSchadule(
      startTime: aStartDate,
      endTime: aEnddate,
      staff: sessionContext.staff!,
      subject: sessionContext.subject!,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      status: 1,
      notes: _notesController.text,
    );

    await sessionContext.createAppointment(
      context: context,
      appointment: appointmentSchadule,
    );

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const EntryPointScreen(selectedIndex: 0),
          ),
          (route) => true);
    }
  }

  Widget buildAppointment({
    required DateTime startDate,
    required SessionContext sessionContext,
  }) =>
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.width * 0.055,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SearchStaffDropdown(),
              const SizedBox(height: 20),
              const SearchSubjectDropdown(),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  CustomDatePicker(
                    controller: _startDateController,
                    startDate: startDate,
                    isleft: true,
                    size: size!,
                    action: () async {
                      _startDateTime = startDate;
                      _startDateTime = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      _startDateController.text =
                          DateFormat.yMMMd().format(_startDateTime!);

                      debugPrint('${sessionContext.endDateTime}');
                    },
                  ),
                  CustomTimePicker(
                    controller: _startTimeController,
                    timeValue: sessionContext.leftTimeValue != null
                        ? sessionContext.leftTimeValue!
                        : '01:00',
                    size: size!,
                    isLeft: true,
                  ),
                  CustomDatePicker(
                    controller: _endDateController,
                    startDate: sessionContext.endDateTime == null
                        ? startDate
                        : sessionContext.endDateTime!,
                    isleft: false,
                    size: size!,
                    action: () async {
                      _endDateTime = startDate;
                      _endDateTime = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime(
                          2000,
                        ),
                        lastDate: DateTime(2101),
                      );
                      _endDateController.text =
                          DateFormat.yMMMd().format(_endDateTime!);
                    },
                  ),
                  CustomTimePicker(
                    controller: _endTimeController,
                    timeValue: sessionContext.rightTimeValue != null
                        ? sessionContext.rightTimeValue!
                        : '01:00',
                    size: size!,
                    isLeft: false,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              inputTextField(
                hintText: 'Meeting notes',
                iconData: Icons.pan_tool,
                controller: _notesController,
                maxLines: 1,
              ),
            ],
          ),
        ),
      );

  Widget inputTextField({
    required IconData iconData,
    required String hintText,
    required TextEditingController controller,
    required int maxLines,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * .005,
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          focusColor: Colors.white,
          icon: const Icon(
            Icons.note,
            color: Colors.grey,
            size: 20,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          hoverColor: Colors.white70,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
