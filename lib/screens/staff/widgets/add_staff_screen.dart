import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/role/role.dart';
import 'package:schedule_app/models/staff/staff.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({
    super.key,
    required this.header,
    this.staff,
  });
  final Staff? staff;
  final String header;

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  Size? size;

  @override
  void initState() {
    super.initState();
    if (widget.staff != null) {
      _nameController.text = widget.staff!.name!;
      _surnameController.text = widget.staff!.surname!;
      _emailController.text = widget.staff!.emailAddress!;
      _contactController.text = widget.staff!.contactNum!;
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
            widget.header.contains('Add staff') ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            widget.header.contains('Add staff') ? 'Add' : 'Edit',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> asyncNavigation({
    required BuildContext context,
    required SessionContext sessionContext,
  }) async {
    Role? role;
    for (var roleModel in sessionContext.roles) {
      if (roleModel.name.contains('ROLE_USER')) {
        role = roleModel;
      }
    }
    if (_fromKey.currentState!.validate()) {
      if (widget.header.contains('Add staff')) {
        Staff staff = Staff(
          name: _nameController.text.trim(),
          surname: _surnameController.text.trim(),
          emailAddress: _emailController.text.trim(),
          password: '${_emailController.text}.tut',
          contactNum: _contactController.text.trim(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: 1,
          roles: {role!},
        );
        await sessionContext.createStaff(
          staff: staff,
          context: context,
        );
      } else {
        widget.staff!.name = _nameController.text.trim();
        widget.staff!.surname = _surnameController.text.trim();
        widget.staff!.contactNum = _contactController.text.trim();
        widget.staff!.updatedAt = DateTime.now();

        debugPrint('${widget.staff!.name}');

        await sessionContext.updateStaff(
          context: context,
          staff: widget.staff!,
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
}
