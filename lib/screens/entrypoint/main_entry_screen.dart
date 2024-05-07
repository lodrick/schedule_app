import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/assigncourse/assign_course.dart';
import 'package:schedule_app/screens/assignsubject/course_screen.dart';
import 'package:schedule_app/screens/attendance/attendance_screen.dart';
import 'package:schedule_app/screens/home/home_screen.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/staff/staff_screen.dart';
import 'package:schedule_app/screens/subject/subject_course_screen.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:sidebarx/sidebarx.dart';

class MainEntryScreen extends StatelessWidget {
  const MainEntryScreen({
    super.key,
    required this.controller,
  });
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isAdmin = false;
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: sessionContext.isloginLoading,
          loading: const CircularProgressIndicator(),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final pageTitle = _getTitleByIndex(controller.selectedIndex);

              isAdmin = verifyUserRole(sessionContext);

              if (isAdmin) {
                switch (controller.selectedIndex) {
                  case 0:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: HomeScreen(),
                        ),
                      ],
                    );
                  case 1:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: StaffScreen(),
                        ),
                      ],
                    );
                  case 2:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SubjectCourseScreen(),
                        ),
                      ],
                    );
                  case 3:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: CourseScreen(),
                        )
                      ],
                    );
                  case 4:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: AssisgnCourseScreen(),
                        )
                      ],
                    );
                  default:
                    return Text(
                      pageTitle,
                      style: theme.textTheme.headlineSmall,
                    );
                }
              } else {
                switch (controller.selectedIndex) {
                  case 0:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: HomeScreen(),
                        ),
                      ],
                    );

                  case 1:
                    return const Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: AttendanceScreen(),
                        ),
                      ],
                    );

                  default:
                    return Text(
                      pageTitle,
                      style: theme.textTheme.headlineSmall,
                    );
                }
              }
            },
          ),
        ),
      );
    });
  }

  bool verifyUserRole(SessionContext sessionContext) {
    for (var role in sessionContext.staff!.roles!) {
      if (role.name.contains('ROLE_ADMIN')) {
        return true;
      }
    }
    return false;
  }

  String _getTitleByIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Staff';
      case 2:
        return 'People';
      case 3:
        return 'Favorites';
      case 4:
        return 'Custom iconWidget';
      case 5:
        return 'Profile';
      case 6:
        return 'Settings';
      default:
        return 'Not found page';
    }
  }
}
