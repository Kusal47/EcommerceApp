import 'package:flutter/material.dart';

class SmallTextSize extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  SmallTextSize({
    super.key,
    this.color,
    required this.text,
    this.size = 14,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
      ),
    );
  }
}
