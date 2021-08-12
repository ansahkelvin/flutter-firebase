import 'package:flutter/material.dart';
import 'package:flutter_tutorial/app/widgets/custom_raisedButton.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    Color color,
    VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            height: 44.0,
            color: color,
            onPressed: onPressed);
}
