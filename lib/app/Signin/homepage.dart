import 'package:flutter/material.dart';
import 'package:flutter_tutorial/app/widgets/show_alert_dialog.dart';
import 'package:flutter_tutorial/services/auth.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmSignout = await showAlertDialog(context,
        title: "Confirm Logout",
        content: "Are you sure you want to logout?",
        defaultActionText: "Ok",
        cancelActionText: "Cancel");

    if (confirmSignout == true) {
      signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Tracker"),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              "Logout",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
