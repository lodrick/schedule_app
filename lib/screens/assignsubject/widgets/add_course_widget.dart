import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/course/course.dart';
import 'package:schedule_app/models/subject/subject.dart';
import 'package:schedule_app/screens/appointment/widgets/seatch_subject.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class AddCourseWidget extends StatefulWidget {
  const AddCourseWidget({
    super.key,
    required this.header,
    this.course,
  });
  final Course? course;
  final String header;

  @override
  State<AddCourseWidget> createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends State<AddCourseWidget> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.course != null) {
      _courseNameController.text = widget.course!.courseName;
      _courseCodeController.text = widget.course!.courseCode;
      _descriptionController.text = widget.course!.description;
    }
  }

  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                appbarView(),
                buidSliverBoxAdapter(sessionContext: sessionContext),
              ],
            ),
            bottomNavigationBar:
                buildBottomButton(sessionContext: sessionContext),
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

  Widget buidSliverBoxAdapter({required SessionContext sessionContext}) =>
      SliverToBoxAdapter(
        child: Form(
          key: _fromKey,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size!.height * .03,
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
                  enabled: widget.header.contains('Add course'),
                  controller: _courseNameController,
                  hintText: 'Course name',
                  iconData: Icons.school,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert course name.',
                  onChanged: (p0) {
                    setState(() {
                      _courseNameController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: widget.header.contains('Add course'),
                  controller: _courseCodeController,
                  hintText: 'Course code',
                  iconData: Icons.code,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert course code.',
                  onChanged: (p0) {
                    setState(() {
                      _courseCodeController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: widget.header.contains('Add course'),
                  controller: _descriptionController,
                  hintText: 'Description',
                  iconData: Icons.description,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert description.',
                  onChanged: (p0) {
                    setState(() {
                      _descriptionController.text = p0!;
                    });
                  },
                ),
                SizedBox(
                  height: size!.height * 0.008,
                ),
                const SearchSubjectDropdown(),
              ],
            ),
          ),
        ),
      );

  Widget buildBottomButton({required SessionContext sessionContext}) =>
      Container(
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
            widget.header.contains('Add course') ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            widget.header.contains('Add course') ? 'Add' : 'Edit',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> asyncNavigation({
    required BuildContext context,
    required SessionContext sessionContext,
  }) async {
    if (_fromKey.currentState!.validate()) {
      List<Subject> subjectList = [];
      if (sessionContext.subject != null) {
        subjectList.add(sessionContext.subject!);
      }

      if (widget.header.contains('Add course')) {
        var course = Course(
            courseName: _courseNameController.text.trim(),
            description: _descriptionController.text.trim(),
            courseCode: _courseCodeController.text.trim(),
            subjects: subjectList,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            status: 1);
        debugPrint('Add course ${course.toJson()}');
        await sessionContext.createCourse(course: course, context: context);
      } else {
        Subject subjectToadd = sessionContext.subject!;
        await sessionContext.assignsubject(
          course: widget.course!,
          subject: subjectToadd,
          context: context,
        );
      }
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const EntryPointScreen(selectedIndex: 3),
            ),
            (route) => true);
      }
    }
  }
}
