import 'package:flutter/material.dart';
import '../Dimension/food_items_list.dart';
import '../Dimension/height_width.dart';
import 'detail_design.dart';
import 'expandable_text.dart';
import 'large_font.dart';

class FoodDetailDesign extends StatelessWidget {
  final int index;

  const FoodDetailDesign(
      {super.key, this.expandedText, required this.index, this.name});
  final String? expandedText;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        top: Dimensions.foodDetailImageSize - 20,
        child: Container(
          padding: EdgeInsets.only(
              left: Dimensions.widthFor20,
              right: Dimensions.widthFor20,
              top: Dimensions.heightFor20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: index >= 0
                    ? DetailDesign(
                        text: name!,
                        text2: ratingDish[index],
                        text3: 'Normal',
                        text4: popularfoodPrice[index].toString(),
                        // text6: '1hr'
                      )
                    : null,
              ),
              SizedBox(
                height: Dimensions.heightFor15,
              ),
              TextSize(
                text: 'Descriptions',
                size: Dimensions.font20,
              ),
              SizedBox(
                height: Dimensions.heightFor10,
              ),
              //Expanding text container
              Expanded(
                child: SingleChildScrollView(
                  child: ExpandableText(
                    text: expandedText!,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
