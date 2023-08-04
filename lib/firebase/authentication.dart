import 'package:firebase_auth/firebase_auth.dart';
class FirebaseAuthModel{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;

  }

  Future<void> signOut() async {

      await _auth.signOut();

  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> resetPassword(String email) async {
      await _auth.sendPasswordResetEmail(email: email);
  }

}
