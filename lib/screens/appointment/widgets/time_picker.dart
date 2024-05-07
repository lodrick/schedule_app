import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:schedule_app/screens/loader_hub.dart';
import 'package:schedule_app/store/session_context.dart';
import 'package:schedule_app/util/util.dart';

class CustomTimePicker extends StatelessWidget {
  const CustomTimePicker({
    super.key,
    required this.controller,
    required this.timeValue,
    required this.isLeft,
    required this.size,
  });
  final TextEditingController controller;
  final String timeValue;
  final bool isLeft;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionContext>(builder: (_, sessionContext, __) {
      if (isLeft) {
        sessionContext.setTimeValue(value: timeValue, isLeft: isLeft);
      } else {
        sessionContext.setTimeValue(value: timeValue, isLeft: isLeft);
      }
      return Observer(
        builder: (_) => LoaderHud(
          inAsyncCall: false,
          loading: const CircularProgressIndicator(),
          child: Container(
            width: 90,
            height: 60,
            padding: EdgeInsets.symmetric(
              vertical: size.height * .001,
              horizontal: size.width * .001,
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              hint: Text(
                timeValue,
                style: const TextStyle(color: Colors.grey),
              ),
              isExpanded: true,
              iconSize: 20,
              style: const TextStyle(color: Colors.blue),
              items: Util.timeList.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                if (isLeft) {
                  sessionContext.setTimeValue(value: value!, isLeft: isLeft);
                } else {
                  sessionContext.setTimeValue(value: value!, isLeft: isLeft);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
