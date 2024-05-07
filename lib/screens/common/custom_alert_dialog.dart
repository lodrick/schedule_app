import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.widget,
    this.circularBorderRadius = 15,
    this.bgColor = Colors.white,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
  });

  final Color bgColor;
  final String title;
  final Widget widget;
  final String positiveBtnText;
  final String negativeBtnText;
  final VoidCallback onPostivePressed;
  final VoidCallback onNegativePressed;
  final double circularBorderRadius;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: widget,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularBorderRadius),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(negativeBtnText),
          onPressed: () {
            Navigator.of(context).pop();
            onNegativePressed;
          },
        ),
        TextButton(
          onPressed: onPostivePressed,
          child: Text(positiveBtnText),
        ),
      ],
    );
  }
}
