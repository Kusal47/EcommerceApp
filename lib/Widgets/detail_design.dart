import 'package:flutter/material.dart';

import '../Dimension/height_width.dart';
import 'icon_text.dart';
import 'large_font.dart';
import 'small_font.dart';

class DetailDesign extends StatelessWidget {
  const DetailDesign({
    super.key,
    required this.text,
    this.text2,
    this.text3,
    this.text4,
  });
  final String text;
  final double? text2;
  final String? text3;
  final String? text4;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextSize(
        text: text,
        size: Dimensions.font26,
      ),
      SizedBox(
        height: Dimensions.heightFor10,
      ),
      Row(
        children: [
        Wrap(
  children: List.generate(
    5,
    (index) {
      double rating = double.tryParse(text2!.toString()) ?? 0.0;
      int filledStars = rating.floor();
      bool hasHalfStar = (rating - filledStars) >= 0.5;
      
      if (index < filledStars) {
        return Icon(
          Icons.star,
          color: Colors.green,
          size: Dimensions.widthFor20,
        );
      } else if (index == filledStars && hasHalfStar) {
        return Icon(
          Icons.star_half,
          color: Colors.green,
          size: Dimensions.widthFor20,
        );
      } else {
        return Icon(
          Icons.star_border,
          color: Colors.green,
          size: Dimensions.widthFor20,
        );
      }
    },
  ),
),
  SizedBox(
            width: Dimensions.widthFor5,
          ),
          SmallTextSize(text: text2!.toString()),
          SizedBox(
            width: Dimensions.widthFor10,
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.heightFor15,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndText(
            icon: Icons.circle_sharp,
            iconColor: Colors.orange,
            text: text3!,
          ),
          IconAndText(
            icon: Icons.attach_money_sharp,
            iconColor: Colors.green,
            text: 'Price: ' + text4!.toString(),
          ),
        ],
      )
    ]);
  }
}
