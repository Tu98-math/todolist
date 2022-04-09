import 'package:firebase_auth/firebase_auth.dart';

import '../pages/auth/sign_in/sign_in_vm.dart';
import '../pages/auth/sign_up/sign_up_vm.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<SignInStatus> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignInStatus.successful;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return SignInStatus.invalidEmail;
        case 'user-disabled':
          return SignInStatus.userDisabled;
        case 'user-not-found':
          return SignInStatus.userNotFound;
        case 'wrong-password':
          return SignInStatus.wrongPassword;
        default:
          return SignInStatus.wrongPassword;
      }
    }
  }

  Future<SignUpStatus> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return SignUpStatus.successfulEmail;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return SignUpStatus.emailAlreadyInUse;
        case 'operation-not-allowed':
          return SignUpStatus.operationNotAllowed;
        case 'invalid-email':
          return SignUpStatus.invalidEmail;
        case 'weak-password':
          return SignUpStatus.weakPassword;
        default:
          return SignUpStatus.weakPassword;
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? currentUser() {
    return _firebaseAuth.currentUser;
  }
}
