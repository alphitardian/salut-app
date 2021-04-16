import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> signInUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  static Future<void> signOutUser() async {
    await auth.signOut();
  }

  static Future<bool> isUserSignIn() async {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
