import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/screens/common/custom_alert_dialog.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/staff/widgets/add_staff_screen.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
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
        return Observer(
          builder: (_) => LoaderHud(
            inAsyncCall: sessionContext.isloginLoading,
            loading: const CircularProgressIndicator(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  appBarvieww(sessionContext),
                  buildStaffView(sessionContext),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                      builder: (context) =>
                          const AddStaffScreen(header: 'Add staff'),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add staff'),
              ),
            ],
          ),
        ),
      );

  Widget buildStaffView(SessionContext sessionContext) => SliverToBoxAdapter(
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
                  for (var staff in sessionContext.staffList)
                    TableRow(
                      children: [
                        TableCell(child: Center(child: Text(staff.name!))),
                        TableCell(child: Center(child: Text(staff.surname!))),
                        TableCell(
                            child: Center(child: Text(staff.emailAddress!))),
                        TableCell(
                          child: Center(child: Text(staff.contactNum!)),
                        ),
                        TableCell(
                          child: Center(child: Text(getStatus(staff.status!))),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              DateFormat.yMMMd().format(staff.updatedAt!),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              DateFormat.yMMMd().format(staff.createdAt!),
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
                                  debugPrint('Edit ${staff.toJson()}');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddStaffScreen(
                                        header: 'Edit staff',
                                        staff: staff,
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
                                      onPostivePressed: () => asyncDeleteButton(
                                            staff: staff,
                                            sessionContext: sessionContext,
                                          ),
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

  Future<void> asyncDeleteButton({
    required Staff staff,
    required SessionContext sessionContext,
  }) async {
    await sessionContext.deleteStaff(
      context: context,
      staff: staff,
    );

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const EntryPointScreen(selectedIndex: 1),
          ),
          (route) => false);
    }
  }
}
