import 'package:flutter/material.dart';

import 'large_font.dart';

class FoodPrice extends StatelessWidget {
  const FoodPrice({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextSize(
        text: '\$' + text + ' | Add to Cart',
        color: Colors.white,
      ),
    );
  }
}
