import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/assignsubject/widgets/add_course_widget.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(
      builder: (_, sessionContext, __) {
        sessionContext.retrieveCourses();
        return Observer(
          builder: (_) => LoaderHud(
            inAsyncCall: false,
            loading: const CircularProgressIndicator(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  appBarvieww(sessionContext),
                  buildSliverToBoxAdapter(sessionContext),
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddCourseWidget(header: "Add course"),
                    ),
                  );
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Course'),
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
                      TableCell(child: Center(child: Text('Course name'))),
                      TableCell(child: Center(child: Text('Course code'))),
                      TableCell(child: Center(child: Text('Description'))),
                      TableCell(child: Center(child: Text('Updated at'))),
                      TableCell(child: Center(child: Text('Created at'))),
                      TableCell(child: Center(child: Text('Action'))),
                    ],
                  ),
                  for (var course in sessionContext.courses)
                    TableRow(
                      children: [
                        TableCell(
                            child: Center(child: Text(course.courseName))),
                        TableCell(
                            child: Center(child: Text(course.courseCode))),
                        TableCell(
                            child: Center(child: Text(course.description))),
                        TableCell(
                          child: Center(
                            child: Text(
                                DateFormat.yMMMd().format(course.updatedAt)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                                DateFormat.yMMMd().format(course.createdAt)),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  debugPrint('Edit ${course.toJson()}');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddCourseWidget(
                                        header: "Edit course",
                                        course: course,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: CustomColor.primaryColors,
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
}
