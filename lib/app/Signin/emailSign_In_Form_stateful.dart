import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tutorial/app/Signin/email_sign_in_model.dart';
import 'package:flutter_tutorial/app/Signin/validaters.dart';
import 'package:flutter_tutorial/app/widgets/show_exception.dart';
import 'package:flutter_tutorial/services/auth.dart';
import 'package:provider/provider.dart';


class EmailSignInFormStateFul extends StatefulWidget with EmailAndPasswwordValidators {
  @override
  _EmailSignInFormStateFulState createState() => _EmailSignInFormStateFulState();
}

class _EmailSignInFormStateFulState extends State<EmailSignInFormStateFul> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;
  EmailFormType _formType = EmailFormType.SignIn;
  String get email => emailController.text;
  String get password => passwordController.text;

  Future<void> _submit(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailFormType.SignIn) {
        await auth.signInUserWithEmail(email, password);
      } else {
        await auth.createUserWithEmailAndPassword(email, password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        "Sign In failed",
        e,
        "OK",
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailFormType.SignIn
          ? EmailFormType.Register
          : EmailFormType.SignIn;
    });
    passwordController.clear();
    emailController.clear();
  }

  void _onEditingComplete() {
    //Switching focus node to password only if there are no errors with email
    final newScope = widget.emailValidator.isValid(email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newScope);
  }

  @override
  void dispose() { 
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  List<Widget> _buildChildren(BuildContext context) {
    final _primaryText =
        _formType == EmailFormType.SignIn ? "Sign In" : "Create an account";
    final _secondaryText = _formType == EmailFormType.SignIn
        ? "Don't have an account? Register"
        : "Already have an account? login";
    final enableButton = widget.emailValidator.isValid(email) &&
        widget.passwordValidator.isValid(password) &&
        !_isLoading;
    return [
      _buildEmailField(),
      SizedBox(height: 8),
      _buildPasswordField(),
      SizedBox(height: 8),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor, minimumSize: Size(20, 44)),
        onPressed: enableButton ? () => _submit(context) : null,
        child: Text(
          _primaryText,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      SizedBox(height: 8),
      TextButton(
        onPressed: _isLoading ? null : _toggleFormType,
        child: Text(_secondaryText),
      ),
    ];
  }

  TextField _buildPasswordField() {
    final showErrorText =
        _submitted && !widget.passwordValidator.isValid(password);
    return TextField(
      controller: passwordController,
      focusNode: _passwordFocusNode,
      onEditingComplete: () => _submit(context),
      onChanged: (password) => _updateState(),
      textInputAction: TextInputAction.done,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        enabled: _isLoading == false,
        errorText: showErrorText ? widget.inValidPasswordErrorText : null,
        labelText: "Password",
      ),
    );
  }

  TextField _buildEmailField() {
    final showErrorText = _submitted && !widget.emailValidator.isValid(email);
    return TextField(
      autocorrect: false,
      autofocus: true,
      controller: emailController,
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _onEditingComplete,
      onChanged: (email) => _updateState(),
      decoration: InputDecoration(
        errorText: showErrorText ? widget.inValidEmailErrorText : null,
        labelText: "Email",
        enabled: _isLoading == false,
        hintText: "test@gmail.com",
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(context),
      ),
    );
  }
}
