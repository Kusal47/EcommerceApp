import 'package:flutter/material.dart';
import '../Dimension/height_width.dart';
import 'icon_text.dart';
import 'large_font.dart';
import 'small_font.dart';

class ListDetailDesign extends StatelessWidget {
  const ListDetailDesign(
      {super.key, required this.text, this.text2, this.text3, this.text4});
  final String text;
  final String? text2;
  final String? text3;
  final double? text4;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextSize(
        text: text,
        size: Dimensions.font20,
      ),
      SizedBox(
        height: Dimensions.heightFor10,
      ),
      SmallTextSize(text: text2!),
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
          // IconAndText(
          //   icon: Icons.access_time_rounded,
          //   iconColor: Colors.orange,
          //   text: text5!,
          // ),
        ],
      )
    ]);
  }
}
