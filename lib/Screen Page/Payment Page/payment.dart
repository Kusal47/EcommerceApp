import 'package:ecommerce_app/Dimension/height_width.dart';
import 'package:flutter/material.dart';

import '../../Widgets/icons.dart';
import '../../Widgets/large_font.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          toolbarHeight: Dimensions.heightFor60 - 5,
          elevation: 0,
          backgroundColor: Colors.grey[300],
          automaticallyImplyLeading: false,
          title: TextSize(
              text: 'Payment Methods',
              color: Colors.black,
              size: Dimensions.font26),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(Dimensions.heightFor10 / 2),
              child: Container(
                child: AppIcons(
                  icon: Icons.arrow_back_ios,
                  bgColor: Colors.white,
                  iconColor: Colors.black,
                  iconSize: Dimensions.font20,
                  size: Dimensions.heightFor30 + 5,
                ),
              ),
            ),
          )),
    );
  }
}
