import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/services/auth.dart';

class SignInBloc {
  SignInBloc({this.auth});
  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoading => _isLoadingController.stream;
  String currentUserId() => auth.currentUser.uid;
  String get getUser => currentUserId();

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false);

      rethrow;
    }
  }

  Future<User> signInAnonymously() => _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() => _signIn(() => auth.signInWithGoogle());

  // Future<User> signInWithFacebook() {}
}
