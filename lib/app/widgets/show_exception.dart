
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showExceptionAlertDialog(BuildContext context, String title,
    Exception exception, String defaultTextAction) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
            _message(
              exception,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(defaultTextAction))
          ],
        );
      });
}

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  } else {
    return exception.toString();
  }
}
