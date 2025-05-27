import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuth {
  static Future<bool> signup({
    required String email,
    required String password,
    required String username,
    required String dateofbirth,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Store user data in Firestore (matching your screenshot structure)
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'password': password, // Not recommended in production
        'username': username,
        'dateofbirth': dateofbirth,
        'userid': userCredential.user!.uid,
      });

      return true; // Signup successful
    } on FirebaseAuthException catch (e) {
      print("Signup error: ${e.message}");
      return false; // Signup failed
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true; // Login successful
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
      return false; // Login failed
    } catch (e) {
      print("Unexpected error: $e");
      return false;
    }
  }
}
