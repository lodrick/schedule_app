import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/common/custom_alert_dialog.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/login_screen.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSidebarX extends StatefulWidget {
  const CustomSidebarX({
    super.key,
    required this.controller,
  });
  final SidebarXController controller;

  @override
  State<CustomSidebarX> createState() => _CustomSidebarXState();
}

class _CustomSidebarXState extends State<CustomSidebarX> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      isAdmin = verifyUserRole(sessionContext);
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: SidebarX(
            controller: widget.controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: CustomColor.primaryColors,
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: scaffoldBackgroundColor,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              selectedTextStyle: const TextStyle(color: Colors.white),
              hoverTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: CustomColor.primaryColors,
                ),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: actionColor.withOpacity(0.37),
                ),
                gradient: const LinearGradient(
                  colors: [accentCanvasColor, canvasColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 30,
                  )
                ],
              ),
              iconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: const SidebarXTheme(
              width: 200,
              decoration: BoxDecoration(
                color: CustomColor.primaryColors,
              ),
            ),
            footerDivider: divider,
            headerBuilder: (context, extended) {
              return const SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: canvasColor,
                  ),
                ),
              );
            },
            items: isAdmin
                ? [
                    SidebarXItem(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: () {
                        debugPrint('Home');
                      },
                    ),
                    const SidebarXItem(
                      icon: Icons.people,
                      label: 'Staff',
                    ),
                    const SidebarXItem(
                      icon: Icons.subject,
                      label: 'Subject',
                    ),
                    const SidebarXItem(
                      icon: Icons.assignment,
                      label: 'Assign subject',
                    ),
                    const SidebarXItem(
                      icon: Icons.school,
                      label: 'Assign course',
                    ),
                    SidebarXItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      selectable: false,
                      onTap: () => _showDisabledAlert(
                        context: context,
                        sessionContext: sessionContext,
                      ),
                    ),
                  ]
                : [
                    SidebarXItem(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: () {
                        debugPrint('Home');
                      },
                    ),
                    SidebarXItem(
                      icon: Icons.calendar_month,
                      label: 'Attendance',
                      onTap: () {
                        debugPrint('Attendance');
                      },
                    ),
                    SidebarXItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      selectable: false,
                      onTap: () => _showDisabledAlert(
                        context: context,
                        sessionContext: sessionContext,
                      ),
                    ),
                  ],
          ),
        ),
      );
    });
  }

  void _showDisabledAlert({
    required BuildContext context,
    required SessionContext sessionContext,
  }) {
    var dialog = CustomAlertDialog(
      title: 'Logout',
      widget: const Text('Are you sure you want to logout?'),
      positiveBtnText: 'Yes',
      negativeBtnText: 'No',
      onPostivePressed: () {
        sessionContext.logout();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
            (route) => false);
      },
      onNegativePressed: () {},
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => dialog,
    );
  }

  bool verifyUserRole(SessionContext sessionContext) {
    for (var role in sessionContext.staff!.roles!) {
      if (role.name.contains('ROLE_ADMIN')) {
        return true;
      }
    }
    return false;
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
