import 'package:ecommerce_app/Widgets/small_font.dart';
import 'package:flutter/material.dart';

import '../Dimension/height_width.dart';

class IconAndText extends StatelessWidget {
  const IconAndText(
      {super.key,
      required this.text,
      required this.icon,
      required this.iconColor});
  final String text;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize16 ,
        ),
        SizedBox(
          width: Dimensions.widthFor5 / 2,
        ),
        SmallTextSize(
          text: text,
        )
      ],
    );
  }
}
