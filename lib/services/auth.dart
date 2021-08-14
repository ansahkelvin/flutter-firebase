import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  Future<User> signInAnonymously();
  Future<void> signOut();
  User get currentUser;
  Stream<User> onAuthStateChanges();
  Future<User> signInWithGoogle();
  Future<User> signInUserWithEmail(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User get currentUser {
    return _firebaseAuth.currentUser;
  }



  @override
  Stream<User> onAuthStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<User> signInUserWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(
              EmailAuthProvider.credential(email: email, password: password));
      return userCredential.user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
            message: "Missing google id token",
            code: "ERROR_MISSING_GOOGLE_ID_TOKEN");
      }
    } else {
      throw FirebaseAuthException(
          message: "Sign in aborted by user", code: "ERROR_ABORTED_BY_USER");
    }
  }

  @override
  Future<User> signInAnonymously() async {
    final UserCredential userCredential =
        await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
