import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/login/login_screen.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/custom_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SessionContext>(
          create: (_) => SessionContext(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: CustomColor.primaryColors,
          scaffoldBackgroundColor: const Color(0xFFEEF1F8),
          colorScheme: ColorScheme.fromSeed(
            seedColor: CustomColor.primaryColors,
          ),
          fontFamily: 'Intel',
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
