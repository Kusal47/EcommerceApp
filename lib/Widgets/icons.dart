import 'package:flutter/material.dart';


class AppIcons extends StatelessWidget {
  const AppIcons(
      {super.key,
      required this.icon,
      this.bgColor = Colors.white,
      this.iconColor = Colors.black,
      this.size = 40,
      this.iconSize = 16,
      });
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: bgColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,

      ),
    );
  }
}
