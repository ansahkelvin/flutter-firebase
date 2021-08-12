import 'package:flutter/material.dart';

import 'custom_raisedButton.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    Color color,
    @required String text,
    Color textColor,
    @required String image,
    VoidCallback onPressed, 
  }) : assert(image != null), assert(text != null), super(
          onPressed: onPressed,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(image),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(image),
              ),
            ],
          ),
        );
}
