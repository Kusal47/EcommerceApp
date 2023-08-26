import 'package:flutter/material.dart';

import '../Dimension/height_width.dart';

class TextSize extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
    final FontWeight fontWeight;

  TextSize(
      {super.key,
      this.color,
      required this.text,
      this.size = 0,
      this.overFlow = TextOverflow.ellipsis,
            this.fontWeight = FontWeight.normal,

      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow==0?null :TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: size == 0 ? Dimensions.font20 : size,
      ),
    );
  }
}
