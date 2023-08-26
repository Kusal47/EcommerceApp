import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future Login(String email, String password) async {
 await auth.signInWithEmailAndPassword(
          email: email, password: password);
   
  }

  Future Register(String email, String password) async {
await auth
          .createUserWithEmailAndPassword(email: email, password: password);
 
  }
  Future  SignOut() async {
    await auth.signOut();
  }
}