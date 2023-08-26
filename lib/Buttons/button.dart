import 'package:flutter/material.dart';

// import '../Display Page/home_page.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key, this.btnname, this.onPressed, this.size});
  final String? btnname;
  final double? size;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(btnname!,
          style: TextStyle(
            fontSize: size,
            color: Colors.blue,
          )),
    );
  }
}
