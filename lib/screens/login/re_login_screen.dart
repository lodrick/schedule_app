import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/models/role/role.dart';
import 'package:schedule_app/payload/loginrequest/login_request.dart';
import 'package:schedule_app/screens/entrypoint/entry_point.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/screens/login/widgets/custom_input.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

class ReLoginScreen extends StatefulWidget {
  const ReLoginScreen({super.key});

  @override
  State<ReLoginScreen> createState() => _ReLoginScreenState();
}

class _ReLoginScreenState extends State<ReLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  Size? size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Consumer<SessionContext>(
      builder: (_, sessionContext, __) {
        return Observer(
          builder: (_) => LoaderHud(
            inAsyncCall: sessionContext.isloginLoading,
            loading: const CircularProgressIndicator(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  buildSliverAppBar(),
                  buidSliverBoxAdapter(sessionContext),
                ],
              ),
              bottomNavigationBar: buildBottomButton(sessionContext),
            ),
          ),
        );
      },
    );
  }

  Widget buildSliverAppBar() => SliverAppBar(
        expandedHeight: size!.height * .35,
        floating: true,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: EdgeInsets.symmetric(vertical: size!.height * .13),
            alignment: Alignment.center,
            height: size!.height * .1,
            width: size!.width * .1,
            decoration: const BoxDecoration(
              color: Color(0xFFEEF1F8),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/gown-hat-1.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          collapseMode: CollapseMode.pin,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CustomInputTextField(
                  enabled: true,
                  controller: _emailController,
                  hintText: 'Email address',
                  iconData: Icons.person,
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
                  iconData: Icons.password,
                  controller: _passwordController,
                  hintText: 'Enter old password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert password',
                  onChanged: (p0) {
                    setState(() {
                      _passwordController.text = p0!;
                    });
                  },
                ),
                CustomInputTextField(
                  enabled: true,
                  iconData: Icons.password_sharp,
                  controller: _rePasswordController,
                  hintText: 'Enter new password',
                  obscureText: true,
                  textInputType: TextInputType.text,
                  size: size!,
                  errorMessage: 'Please insert password',
                  onChanged: (p0) {
                    setState(() {
                      _rePasswordController.text = p0!;
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
          onPressed: () =>
              asyncNavigation(context: context, sessionContext: sessionContext),
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
            CupertinoIcons.arrow_right,
            color: Colors.white,
          ),
          label: const Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<void> asyncNavigation({
    required BuildContext context,
    required SessionContext sessionContext,
  }) async {
    if (_fromKey.currentState!.validate()) {
      await sessionContext.updateAuthorization(
        context: context,
        loginRequest: LoginRequest(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          rePassword: _rePasswordController.text.trim(),
        ),
      );
    }
    sessionContext.retrieveRoles();
    Role? role;
    if (context.mounted) {
      if (sessionContext.staff != null) {
        if (sessionContext.staff!.roles!.isNotEmpty) {
          for (var rolev in sessionContext.staff!.roles!) {
            if (rolev.name == 'ROLE_ADMIN') {
              role = rolev;
            }
          }

          if (role != null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const EntryPointScreen(selectedIndex: 0),
                ),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const EntryPointScreen(selectedIndex: 0),
                ),
                (route) => false);
          }
        }
      }
    }
  }
}
