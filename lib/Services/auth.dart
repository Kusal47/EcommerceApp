import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future Login(String email, String password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

//   Future Register(String email, String password) async {
// await auth
//           .createUserWithEmailAndPassword(email: email, password: password);

//   }
  Future<void> Register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Add user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'Email': email,
        'First Name': '', // Set to desired initial value
        'Last Name': '', // Set to desired initial value
        'Password': password, // Do NOT store password in plaintext!
        'Phone Number': '', // Set to desired initial value
      });
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  Future SignOut() async {
    await auth.signOut();
  }
}
