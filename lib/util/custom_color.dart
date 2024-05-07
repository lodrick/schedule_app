import 'package:flutter/material.dart';

class CustomColor {
  CustomColor._();

  static const Color primaryColors = Color(0xFF184F59);
  //static const Color primaryColorLight = Color(0xFF58E3E1);
  static const Color primaryColorLight = Color(0xFFFFEFEE);
  static const Color primaryScaffoldBackgroundColor = Color(0xFFEEF1F8);
  static const Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
  static const Color startingColor = Color.fromRGBO(70, 112, 112, 1.0);
  static const Color primaryTextColor = Color(0xFF1A1316);
  static const Color secondaryTextColor = Color(0xFF8391A0);
  static const Color tertiaryTextColor = Color(0xFFB5ADAC);
  static const Color hintTextColor = Color(0xFFE4E0E8);
  static Color greenColor = Colors.green.shade400;
  static const Color blueColor = Colors.lightBlueAccent;
  static const purpleColor = Color(0xff6688FF);
  static const darkTextColor = Color(0xff1F1A3D);
  static const lightTextColor = Color(0xff999999);
  static const textFieldColor = Color(0xffE7EBEC);
  static const borderColor = Color(0xffD9D9D9);

  static const kBackgroundColor = Color(0xFFF8F8F8);
  static const kShadowColor = Color(0xFFE6E6E6);

  static const Color appBackgroundColor = Color(0xFFFFF7EC);
  static const Color topBarBackgroundColor = Color(0xFFFFD974);
  static const Color selectedTabBackgroundColor = Color(0xFFFFC442);
  static const Color unSelectedTabBackgroundColor = Color(0xFFFFFFFC);
  static const Color subTitleTextColor = Color(0xFF9F988F);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CustomColor.appBackgroundColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );

  static const TextTheme lightTextTheme = TextTheme(
    titleLarge: _titleLight,
    titleMedium: _subTitleLight,
    //button: _buttonLight,
    headlineLarge: _greetingLight,
    headlineMedium: _searchLight,
    bodyLarge: _selectedTabLight,
    bodyMedium: _unSelectedTabLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    titleLarge: _titleDark,
    titleMedium: _subTitleDark,
    //button: _buttonDark,
    headlineLarge: _greetingDark,
    headlineMedium: _searchDark,
    bodyLarge: _selectedTabDark,
    bodyMedium: _unSelectedTabDark,
  );

  static const TextStyle _titleLight = TextStyle(
    color: Colors.black,
    fontSize: 28,
  );

  static const TextStyle _subTitleLight = TextStyle(
    color: subTitleTextColor,
    fontSize: 28,
    height: 1.5,
  );

  /*static const TextStyle _buttonLight = TextStyle(
    color: Colors.black,
    fontSize: 28,
  );*/

  static const TextStyle _greetingLight = TextStyle(
    color: Colors.black,
    fontSize: 28,
  );

  static const TextStyle _searchLight = TextStyle(
    color: Colors.black,
    fontSize: 28,
  );

  static const TextStyle _selectedTabLight = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  static const TextStyle _unSelectedTabLight = TextStyle(
    color: Colors.grey,
    fontSize: 28,
  );

  static final TextStyle _titleDark = _titleLight.copyWith(color: Colors.white);

  static final TextStyle _subTitleDark =
      _subTitleLight.copyWith(color: Colors.white70);

  /*static final TextStyle _buttonDark =
      _buttonLight.copyWith(color: Colors.black);*/

  static final TextStyle _greetingDark =
      _greetingLight.copyWith(color: Colors.black);

  static final TextStyle _searchDark =
      _searchDark.copyWith(color: Colors.black);

  static final TextStyle _selectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white);

  static final TextStyle _unSelectedTabDark =
      _selectedTabDark.copyWith(color: Colors.white70);

  static Map<int, Color> color = {
    50: const Color.fromRGBO(24, 79, 89, .1),
    100: const Color.fromRGBO(24, 79, 89, .2),
    200: const Color.fromRGBO(24, 79, 89, .3),
    300: const Color.fromRGBO(24, 79, 89, .4),
    400: const Color.fromRGBO(24, 79, 89, .5),
    500: const Color.fromRGBO(24, 79, 89, .6),
    600: const Color.fromRGBO(24, 79, 89, .7),
    700: const Color.fromRGBO(24, 79, 89, .8),
    800: const Color.fromRGBO(24, 79, 89, .9),
    900: const Color.fromRGBO(24, 79, 89, 1),
  };
}
