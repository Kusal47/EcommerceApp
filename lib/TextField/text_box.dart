import 'package:flutter/material.dart';
import '../../../Dimension/height_width.dart';
import '../../../Widgets/large_font.dart';
import '../../../Widgets/small_font.dart';

class TextViewBox extends StatelessWidget {
  const TextViewBox({super.key, required this.name, required this.data});
  final String name;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSize(
            text: name,
            color: Colors.black,
            size: Dimensions.font24,
          ),
          Container(
            height: Dimensions.heightFor60,
            width: Dimensions.screenWidth,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SmallTextSize(
              text: data,
              color: Colors.black,
              size: Dimensions.font20,
            ),
          ),
        ],
      ),
    );
  }
}
