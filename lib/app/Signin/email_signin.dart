import 'package:flutter/material.dart';

import 'package:flutter_tutorial/app/Signin/emailSign_In_Form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          elevation: 2.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: EmailSignInFormStateFul(),
            ),
          ),
        ));
  }
}
