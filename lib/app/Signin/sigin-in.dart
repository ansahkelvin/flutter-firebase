import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/app/Signin/email_signin.dart';
import 'package:flutter_tutorial/app/Signin/sign_in_bloc.dart';
import 'package:flutter_tutorial/app/widgets/customSignIn.dart';
import 'package:flutter_tutorial/app/widgets/show_exception.dart';
import 'package:flutter_tutorial/app/widgets/social_media_login.dart';
import 'package:flutter_tutorial/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  //Create a constructor so we wont repeat using provider of context
  const SignInPage({Key key, this.bloc}) : super(key: key);
  final SignInBloc bloc;

  //Create Provider for the Bloc class
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) {
          return SignInPage(
            bloc: bloc,
          );
        },
        child: SignInPage(),
      ),
    );
  }

  void showException(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      "Sign in failed",
      exception,
      "OK",
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      showException(context, e);
    }
  }

  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      showException(context, e);
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
    // final bloc = Provider.of<SignInBloc>(context, listen: false);
    //No longer in use since the bloc is passed as a constructor now.

    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        centerTitle: true,
        elevation: 1,
      ),
      body: StreamBuilder<bool>(
          stream: bloc.isLoading,
          initialData: false,
          builder: (context, snapshot) {
            return _buildContents(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(BuildContext context, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            !isLoading
                ? Text(
                    "Sign In",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
            SizedBox(
              height: 48,
            ),
            SocialSignInButton(
              color: Colors.white,
              textColor: Colors.black87,
              image: "images/google-logo.png",
              text: "Sign in with Google",
              onPressed: isLoading ? null : () => signInWithGoogle(context),
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
              onPressed: isLoading ? null : () => signInAnonymously(context),
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
