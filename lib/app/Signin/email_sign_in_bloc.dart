import 'dart:async';
import 'package:flutter_tutorial/app/Signin/email_sign_in_model.dart';

class EmailSignInBloc {
  final StreamController<EmailSignInModel> _streamController =
      StreamController<EmailSignInModel>();

  Stream<EmailSignInModel> get modelStream => _streamController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _streamController.close();
  }

  void updateWith({
    String email,
    String password,
    EmailFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    //Update model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      isSubmitted: submitted,
    );
    //add updated to model controller
    _streamController.add(_model);
  }
}
