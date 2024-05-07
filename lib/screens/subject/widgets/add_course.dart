import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/appointment/widgets/seatch_subject.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
              vertical: size!.height * .03,
              horizontal: size!.width * .04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Add Course',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _courseNameController,
                  hintText: 'Course name',
                  iconData: Icons.school,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert course name',
                  onChanged: (p0) {
                    setState(() {
                      _courseNameController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _courseCodeController,
                  hintText: 'Course code',
                  iconData: Icons.code,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert course code',
                  onChanged: (p0) {
                    setState(() {
                      _courseCodeController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _descriptionController,
                  hintText: 'Description',
                  iconData: Icons.description,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert description',
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

  Widget buildBottomButton(SessionContext sessionContext) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: size!.width * 0.08,
          vertical: 8.0,
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
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
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
