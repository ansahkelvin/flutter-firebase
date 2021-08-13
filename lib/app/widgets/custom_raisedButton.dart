import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;

  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 4.0,
    this.onPressed,
    this.height: 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      disabledColor: color,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: child,
      color: color,
    );
  }
}
