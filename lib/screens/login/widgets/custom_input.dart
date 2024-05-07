import 'package:flutter/material.dart';

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    required this.iconData,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
    required this.size,
    required this.onChanged,
    required this.enabled,
    required this.errorMessage,
  });
  final IconData iconData;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Size size;
  final TextInputType textInputType;
  final Function(String?) onChanged;
  final bool enabled;
  final String errorMessage;

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * .005,
      ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage.isNotEmpty ? errorMessage : null;
          } else if (hintText.contains('Email address') &&
              !_emailRegex.hasMatch(value)) {
            return 'Please insert valid email address.';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          focusColor: Colors.white,
          icon: Icon(
            iconData,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          hoverColor: Colors.white70,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
