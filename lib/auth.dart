import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignInEmail(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return user;
    } catch (e) {
      print("Error signing in with email and password: $e");
      return null;
    }
  }

  Future<User?> handleSignUp(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;
      return user;
    } catch (e) {
      print("Error signing up with email and password: $e");
      return null;
    }
  }
}
