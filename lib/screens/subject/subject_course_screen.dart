import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/subject/subject.dart';
import 'package:schedule_app/screens/common/custom_alert_dialog.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/subject/widgets/add_course.dart';
import 'package:schedule_app/screens/subject/widgets/add_subject.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class SubjectCourseScreen extends StatefulWidget {
  const SubjectCourseScreen({super.key});

  @override
  State<SubjectCourseScreen> createState() => _SubjectCourseScreenState();
}

class _SubjectCourseScreenState extends State<SubjectCourseScreen> {
  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      sessionContext.retrieveSubjects();

      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                appBarView(sessionContext),
                buildSliverToBoxAdapter(sessionContext),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget appBarView(SessionContext sessionContext) => SliverAppBar(
        expandedHeight: size!.height * .08,
        floating: true,
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(238, 241, 248, 1),
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.width * 0.04,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddCourseScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Course'),
              ),
              SizedBox(
                width: size!.width * .008,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddSubjectScreen(header: "Add subject"),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Subject'),
              ),
            ],
          ),
        ),
      );

  Widget buildSliverToBoxAdapter(SessionContext sessionContext) =>
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
                      TableCell(child: Center(child: Text('Subject name'))),
                      TableCell(child: Center(child: Text('Subject code'))),
                      TableCell(
                          child: Center(child: Text('Subject description'))),
                      TableCell(
                          child: Center(child: Text('Assigned to course'))),
                      TableCell(child: Center(child: Text('Updated at'))),
                      TableCell(child: Center(child: Text('Created at'))),
                      TableCell(child: Center(child: Text('Action'))),
                    ],
                  ),
                  for (var subject in sessionContext.subjects)
                    TableRow(children: [
                      TableCell(
                          child: Center(child: Text(subject.subjectName!))),
                      TableCell(
                          child: Center(child: Text(subject.subjectCode!))),
                      TableCell(
                          child: Center(child: Text(subject.description!))),
                      TableCell(
                          child: Center(child: Text('${subject.isAssigned}'))),
                      TableCell(
                          child: Center(
                              child: Text(DateFormat.yMMMd()
                                  .format(subject.updatedAt!)))),
                      TableCell(
                          child: Center(
                              child: Text(DateFormat.yMMMd()
                                  .format(subject.createdAt!)))),
                      TableCell(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              debugPrint('Edit ${subject.toJson()}');
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddSubjectScreen(
                                    header: "Edit subject",
                                    subject: subject,
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
                                title: 'Delete Subject',
                                widget: const Text(
                                    'Are you sure, \nyou wnat to delete this subject?'),
                                positiveBtnText: 'Yes',
                                negativeBtnText: 'No',
                                onPostivePressed: () => asyncDeleteSubject(
                                  subject: subject,
                                  sessionContext: sessionContext,
                                ),
                                onNegativePressed: () {},
                              );

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => dialog);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      )),
                    ]),
                ],
              ),
            ],
          ),
        ),
      );

  Future<void> asyncDeleteSubject({
    required Subject subject,
    required SessionContext sessionContext,
  }) async {
    await sessionContext.deleteSubject(
      subject: subject,
      context: context,
    );
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const EntryPointScreen(selectedIndex: 2),
          ),
          (route) => false);
    }
  }
}
