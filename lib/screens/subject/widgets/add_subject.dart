import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/subject/subject.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({
    super.key,
    required this.header,
    this.subject,
  });
  final Subject? subject;
  final String header;

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.subject != null) {
      _subjectNameController.text = widget.subject!.subjectName!;
      _subjectCodeController.text = widget.subject!.subjectCode!;
      _descriptionController.text = widget.subject!.description!;
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
                  controller: _subjectNameController,
                  hintText: 'Subject name',
                  iconData: Icons.subject,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert subject name.',
                  onChanged: (p0) {
                    setState(() {
                      _subjectNameController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  controller: _subjectCodeController,
                  hintText: 'Subject code',
                  iconData: Icons.code,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert subject code.',
                  onChanged: (p0) {
                    setState(() {
                      _subjectCodeController.text = p0!;
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
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            widget.header.contains('Add subject') ? 'Add' : 'Edit',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> asyncNavigation({
    required BuildContext context,
    required SessionContext sessionContext,
  }) async {
    if (_fromKey.currentState!.validate()) {
      if (widget.header.contains('Add subject')) {
        var subject = Subject(
            subjectName: _subjectNameController.text.trim(),
            description: _descriptionController.text.trim(),
            subjectCode: _subjectCodeController.text.trim(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isAssigned: false,
            status: 1);

        await sessionContext.createSubject(
          subject: subject,
          context: context,
        );
      } else {
        widget.subject!.subjectName = _subjectNameController.text.trim();
        widget.subject!.subjectCode = _subjectCodeController.text.trim();
        widget.subject!.description = _descriptionController.text.trim();
        widget.subject!.updatedAt = DateTime.now();

        debugPrint('${widget.subject!.toJson()}');
        await sessionContext.updateSubject(
            subject: widget.subject!, context: context);
      }

      if (context.mounted) {
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const EntryPointScreen(selectedIndex: 2),
              ),
              (route) => true);
        }
      }
    }
  }
}
