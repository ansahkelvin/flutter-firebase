import 'package:flutter/material.dart';
import 'package:flutter_tutorial/app/Signin/email_signin.dart';

import 'package:flutter_tutorial/app/widgets/customSignIn.dart';
import 'package:flutter_tutorial/app/widgets/social_media_login.dart';
import 'package:flutter_tutorial/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  Future<void> signInWithGoogle(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInAnonymously(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  void signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
        elevation: 1,
      ),
      body: _buildContents(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign In",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 48,
            ),
            SocialSignInButton(
              color: Colors.white,
              textColor: Colors.black87,
              image: "images/google-logo.png",
              text: "Sign in with Google",
              onPressed: () => signInWithGoogle(context),
            ),
            SizedBox(
              height: 8,
            ),
            SocialSignInButton(
              color: Color(0xff334d92),
              textColor: Colors.white,
              image: "images/facebook-logo.png",
              text: "Sign in with Facebook",
              onPressed: () {},
            ),
            SizedBox(
              height: 8,
            ),
            SignInButton(
              onPressed: () => signInWithEmail(context),
              textColor: Colors.white,
              text: "Sign in with Email",
              color: Colors.teal[700],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            SignInButton(
              onPressed: () => signInAnonymously(context),
              textColor: Colors.black,
              text: "Go anonymous",
              color: Colors.lime[300],
            )
          ],
        ),
      ),
    );
  }
}
