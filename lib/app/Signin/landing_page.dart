
import 'package:flutter/material.dart';

import 'package:flutter_tutorial/app/Signin/homepage.dart';
import 'package:flutter_tutorial/app/Signin/sigin-in.dart';
import 'package:flutter_tutorial/services/auth.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
        stream: auth.onAuthStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data;
            if (data == null) {
              return SignInPage();
            }
            return HomePage();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });

  
  }
}
