import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Dimension/height_width.dart';
import '../../Login Register/login_page.dart';
import 'food_page.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodPage()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.food_bank,
            size: 70,
            color: Colors.pinkAccent,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: Dimensions.heightFor20,
          ),
        ],
      ),
    ));
  }
}
