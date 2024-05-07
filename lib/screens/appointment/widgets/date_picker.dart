import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.controller,
    required this.startDate,
    required this.isleft,
    required this.size,
    required this.action,
  });
  final TextEditingController controller;
  final DateTime startDate;
  final bool isleft;
  final Size size;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    controller.text = DateFormat.yMMMd().format(startDate);
    return Container(
      width: 200,
      height: 60,
      padding: EdgeInsets.symmetric(
        vertical: size.height * .000,
        horizontal: size.width * .000,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          icon: Icon(
            isleft ? Icons.access_time : Icons.arrow_forward,
            color: Colors.grey,
            size: 20,
          ),
          labelText: isleft ? 'Start date' : 'End date',
          filled: true,
          fillColor: Colors.white,
        ),
        readOnly: true,
        onTap: action,
      ),
    );
  }
}
