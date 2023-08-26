import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Services/auth.dart';
import '../Buttons/button.dart';
import '../Screen Page/Home/food_page.dart';
import '../TextField/text_field.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 98, 153, 248),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Page'),
          backgroundColor: Color.fromARGB(255, 98, 153, 248),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  TextFields(
                    controller: emailController,
                    hinttext: 'Email',
                    isEmail: true,
                  ),
                  TextFields(
                    controller: passController,
                    isPassword: true,
                    hinttext: 'Password',
                  ),
                  Buttons(
                    btnname: 'Login',
                    size: 20,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await AuthService().Login(
                            emailController.text,
                            passController.text,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => FoodPage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Get.snackbar(
                              'Login Failed',
                              'Invalid Email or Password',
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                              barBlur: 20,
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Login Failed'),
                                  content:
                                      Text('An error occurred during login.'),
                                  actions: [
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      }
                      emailController.clear();
                      passController.clear();
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 27, 4, 231),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
