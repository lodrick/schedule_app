import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/student/student.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class CaptureAttendanceScreen extends StatefulWidget {
  const CaptureAttendanceScreen(
      {super.key, required this.header, this.student});
  final String header;
  final Student? student;

  @override
  State<CaptureAttendanceScreen> createState() =>
      _CaptureAttendanceScreenState();
}

class _CaptureAttendanceScreenState extends State<CaptureAttendanceScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  Size? size;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!.name!;
      _surnameController.text = widget.student!.surname!;
      _emailController.text = widget.student!.emailAddress!;
      _contactController.text = widget.student!.contactNum!;
    }
  }

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
                appbarView(),
                buidSliverBoxAdapter(sessionContext),
              ],
            ),
            bottomNavigationBar: buildBottomButton(sessionContext),
          ),
        ),
      );
    });
  }

  Widget appbarView() => SliverAppBar(
        expandedHeight: size!.height * 0.08,
        floating: true,
        pinned: true,
        backgroundColor: const Color.fromRGBO(238, 241, 248, 1),
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(
            vertical: size!.height * 0.02,
            horizontal: size!.height * 0.015,
          ),
          child: const Column(
            children: <Widget>[],
          ),
        ),
      );

  Widget buidSliverBoxAdapter(SessionContext sessionContext) =>
      SliverToBoxAdapter(
        child: Form(
          key: _fromKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size!.height * .02,
              horizontal: size!.width * .04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.header,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _nameController,
                  hintText: 'First name',
                  iconData: Icons.person,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert First name',
                  onChanged: (p0) {
                    setState(() {
                      _nameController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _surnameController,
                  hintText: 'Last name',
                  iconData: Icons.person,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert Last name',
                  onChanged: (p0) {
                    setState(() {
                      _surnameController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _emailController,
                  hintText: 'Email address',
                  iconData: Icons.contact_mail_sharp,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  size: size!,
                  errorMessage: 'Please insert email address',
                  onChanged: (p0) {
                    setState(() {
                      _emailController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _contactController,
                  hintText: 'Contact number',
                  iconData: Icons.contact_phone,
                  obscureText: false,
                  textInputType: TextInputType.phone,
                  size: size!,
                  errorMessage: 'Please insert contact number',
                  onChanged: (p0) {
                    setState(() {
                      _contactController.text = p0!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildBottomButton(SessionContext sessionContext) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: size!.width * 0.08,
          vertical: 8.0,
        ),
        child: ElevatedButton.icon(
          onPressed: () => asyncNavigation(
            context: context,
            sessionContext: sessionContext,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColor.primaryColors,
            minimumSize: const Size(double.infinity, 56),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          icon: Icon(
            widget.header.contains('Add student') ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            widget.header.contains('Add student') ? 'Add' : 'Edit',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> asyncNavigation({
    required BuildContext context,
    required SessionContext sessionContext,
  }) async {
    if (widget.header.contains('Add student')) {
      Student student = Student(
        name: _nameController.text.trim(),
        surname: _surnameController.text.trim(),
        emailAddress: _emailController.text.trim(),
        password: '${_emailController.text}.tut',
        contactNum: _contactController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: 1,
      );
      await sessionContext.createStudentRecord(
        context: context,
        student: student,
      );
    } else {
      widget.student!.name = _nameController.text.trim();
      widget.student!.surname = _surnameController.text.trim();
      widget.student!.contactNum = _contactController.text.trim();
      widget.student!.updatedAt = DateTime.now();
      debugPrint('${widget.student!.toJson()}');

      await sessionContext.updateStudentRecord(
        context: context,
        student: widget.student!,
      );
    }
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const EntryPointScreen(selectedIndex: 1),
          ),
          (route) => true);
    }
  }
}
