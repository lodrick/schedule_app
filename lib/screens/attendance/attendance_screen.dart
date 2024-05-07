import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/attendance/widgets/capture_attendance.dart';
import 'package:schedule_app/screens/common/custom_alert_dialog.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: sessionContext.isloginLoading,
          loading: const CircularProgressIndicator(),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                appBarvieww(sessionContext),
                buildSliverToBoxView(sessionContext),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget appBarvieww(SessionContext sessionContext) => SliverAppBar(
        expandedHeight: size!.height * 0.08,
        floating: true,
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(238, 241, 248, 1),
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.height * 0.08,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CaptureAttendanceScreen(
                        header: 'Add student',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add student record'),
              ),
            ],
          ),
        ),
      );

  Widget buildSliverToBoxView(SessionContext sessionContext) =>
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    decoration: BoxDecoration(color: Colors.grey),
                    children: [
                      TableCell(child: Center(child: Text('Name'))),
                      TableCell(child: Center(child: Text('Surname'))),
                      TableCell(child: Center(child: Text('Email address'))),
                      TableCell(child: Center(child: Text('Contact number'))),
                      TableCell(child: Center(child: Text('Status'))),
                      TableCell(child: Center(child: Text('Updated at'))),
                      TableCell(child: Center(child: Text('Created at'))),
                      TableCell(child: Center(child: Text('Action'))),
                    ],
                  ),
                  for (var student in sessionContext.students)
                    TableRow(
                      children: [
                        TableCell(child: Center(child: Text(student.name!))),
                        TableCell(child: Center(child: Text(student.surname!))),
                        TableCell(
                            child: Center(child: Text(student.emailAddress!))),
                        TableCell(
                          child: Center(child: Text(student.contactNum!)),
                        ),
                        TableCell(
                          child:
                              Center(child: Text(getStatus(student.status!))),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              DateFormat.yMMMd().format(student.updatedAt!),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              DateFormat.yMMMd().format(student.createdAt!),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  debugPrint('Edit ${student.toJson()}');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CaptureAttendanceScreen(
                                        header: 'Edit staff',
                                        student: student,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: CustomColor.primaryColors,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  var dialog = CustomAlertDialog(
                                      title: 'Delete Staff',
                                      widget: const Text(
                                          'Are you sure, \nyou wnat to delete this staff?'),
                                      positiveBtnText: 'Yes',
                                      negativeBtnText: 'No',
                                      onPostivePressed: () {},
                                      onNegativePressed: () {});
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => dialog,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      );

  String getStatus(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'Inactive';
      case 3:
        return 'Pending';
      default:
        return 'Unknown';
    }
  }
}
