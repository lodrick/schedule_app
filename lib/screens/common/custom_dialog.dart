import 'package:flutter/material.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/screens/assigncourse/widgets/course_dropdown.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.sessionContext,
    required this.staff,
  });
  final SessionContext sessionContext;
  final Staff staff;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController contactController = TextEditingController();

    nameController.text = '${staff.name} ${staff.surname}';
    emailController.text = staff.emailAddress!;
    contactController.text = staff.contactNum!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Assign course to staff',
              softWrap: true,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            CustomInputTextField(
              enabled: false,
              controller: nameController,
              hintText: 'Names',
              iconData: Icons.person,
              obscureText: false,
              textInputType: TextInputType.text,
              size: size,
              errorMessage: '',
              onChanged: (p0) {
                nameController.text = p0!;
              },
            ),
            CustomInputTextField(
              enabled: false,
              controller: emailController,
              hintText: 'Email address',
              iconData: Icons.email,
              obscureText: false,
              textInputType: TextInputType.text,
              size: size,
              errorMessage: '',
              onChanged: (p0) {
                emailController.text = p0!;
              },
            ),
            CustomInputTextField(
              enabled: false,
              controller: contactController,
              hintText: 'Contact number',
              iconData: Icons.contacts,
              obscureText: false,
              textInputType: TextInputType.text,
              size: size,
              errorMessage: '',
              onChanged: (p0) {
                contactController.text = p0!;
              },
            ),
            const SizedBox(height: 8.0),
            CourseDropdown(sessionContext: sessionContext),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () => confirmButton(
                    sessionContext: sessionContext,
                    context: context,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> confirmButton({
    required SessionContext sessionContext,
    required BuildContext context,
  }) async {
    await sessionContext.assignCourse(
      context: context,
      staff: staff,
      course: sessionContext.course!,
    );

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const EntryPointScreen(selectedIndex: 4),
          ),
          (route) => true);
    }
  }
}
