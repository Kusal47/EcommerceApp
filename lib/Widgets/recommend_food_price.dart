import 'package:flutter/material.dart';

import '../Dimension/height_width.dart';
import 'large_font.dart';

class RecommendFoodPrice extends StatelessWidget {
  const RecommendFoodPrice({
    super.key,
    required this.text,
    this.size,
  });
  final String text;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextSize(
        text: '\$' + text + ' X ',
        color: Colors.black87,
        size: size ?? Dimensions.font26,
      ),
    );
  }
}
