import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../Buttons/button.dart';
import '../TextField/text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController FirstnameC = TextEditingController();
  TextEditingController LastnameC = TextEditingController();
  TextEditingController PhoneC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController passConfirm = TextEditingController();
  bool? isChecked = false;
  bool isHidden = false;

  final _formKey = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 98, 153, 248),
      appBar: AppBar(
        title: Text('Register Page'),
        backgroundColor: Color.fromARGB(255, 98, 153, 248),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFields(
                  controller: FirstnameC,
                  hinttext: 'First Name',
                  isFname: true,
                ),
                TextFields(
                  controller: LastnameC,
                  hinttext: 'Last Name',
                  isLname: true,
                ),
                TextFields(
                  controller: PhoneC,
                  hinttext: 'Phone number',
                  isPhone: true,
                ),
                TextFields(
                  controller: emailC,
                  hinttext: 'Email',
                  isEmail: true,
                ),
                TextFields(
                  controller: passC,
                  hinttext: 'Password',
                  isPassword: true,
                ),
                TextFormField(
                  obscureText: isHidden ? false : true,
                  controller: passConfirm,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Confirm your Password';
                    }
                    if (value != passC.text) {
                      return 'Password did not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Confirm Your Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                      icon: isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.remove_red_eye_outlined),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text('Terms and Conditions'),
                  ],
                ),
                Buttons(
                    btnname: 'Register',
                    size: 20,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked == true) {
                          await AuthService().Register(emailC.text, passC.text);
                          await FirebaseFirestore.instance
                              .collection('users')
                              .add({
                            'First Name': FirstnameC.text,
                            'Last Name': LastnameC.text,
                            'Email': emailC.text,
                            'Phone Number': int.parse(PhoneC.text),
                            'Password': passC.text.trim(),
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                          FirstnameC.clear();
                          LastnameC.clear();
                          PhoneC.clear();
                          emailC.clear();
                          passC.clear();
                          passConfirm.clear();
                        }else{
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Terms and Conditions'),
                                  content: Text(
                                      'Please accept the Terms and Conditions'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              });
                        }
                      }else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please fill all the fields'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            });
                      }
                    }),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
