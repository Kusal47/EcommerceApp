import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  TextFields(
      {Key? key,
      this.controller,
      this.hinttext,
      this.isEmail = false,
      this.isPhone = false,
      this.isPassword = false,
      this.isFname = false,
      this.isLname = false})
      : super(key: key);

  final TextEditingController? controller;
  final String? hinttext;
  final bool? isEmail;
  final bool? isPhone;
  final bool? isFname;
  final bool? isLname;
  final bool? isPassword;

  void dispose() {
    controller?.dispose();
  }

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          obscureText: widget.isPassword! ? isHidden : false,
          controller: widget.controller,
          keyboardType: widget.isEmail!
              ? TextInputType.emailAddress
              : widget.isPhone!
                  ? TextInputType.phone
                  : TextInputType.text,
          validator: (value) {
            if (widget.isFname!) {
              if (value == null || value.isEmpty) {
                return 'Please enter your First name';
              }
              return null;
            }
            if (widget.isLname!) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Last name';
              }
              return null;
            }
            if (widget.isPhone!) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length != 10 && value.length > 10) {
                return 'Phone number is invalid';
              }

              return null;
            }
            if (widget.isEmail!) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Email';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter valid Email';
              }
              return null;
            }
            if (widget.isPassword!) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Password';
              } else if (value.length < 8) {
                return 'Password must be atleast 8 character';
              }
              return null;
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.hinttext,
            suffixIcon: widget.isPassword!
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    icon: isHidden
                        ? Icon(Icons.remove_red_eye_outlined)
                        : Icon(Icons.visibility_off))
                : null,
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
