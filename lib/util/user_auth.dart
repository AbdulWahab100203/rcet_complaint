import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {
  static Future<bool> signup({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      return true; // Signup successful
    } on FirebaseAuthException catch (e) {
      print("Signup error: ${e.message}");
      return false; // Signup failed
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }
}
