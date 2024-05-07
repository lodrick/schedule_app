import 'package:flutter/material.dart';

class LoaderHud extends StatelessWidget {
  const LoaderHud({
    super.key,
    this.opacity = 0.3,
    this.color = Colors.transparent,
    this.dismissble = false,
    required this.inAsyncCall,
    required this.loading,
    required this.child,
  });

  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget loading;
  final bool dismissble;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;
    return Stack(
      children: <Widget>[
        child,
        Opacity(
          opacity: opacity,
          child: ModalBarrier(
            dismissible: dismissble,
            color: color,
          ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: loading,
          ),
        ),
      ],
    );
  }
}
