import 'package:flutter/material.dart';

import 'custom_raisedButton.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
   @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
          ),
          onPressed: onPressed,
          color: color,
        );
}
