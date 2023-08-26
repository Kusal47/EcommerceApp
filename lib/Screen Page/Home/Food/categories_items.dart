import 'package:ecommerce_app/Screen%20Page/Home/Food/recommended_food.dart';
import 'package:ecommerce_app/Widgets/large_font.dart';
import 'package:ecommerce_app/Widgets/small_font.dart';
import 'package:flutter/material.dart';
import '../../../Dimension/food_items_list.dart';
import '../../../Dimension/height_width.dart';
import '../../../Widgets/gridview.dart';
import '../../../Widgets/icons.dart';

class CategoriesItemsPage extends StatefulWidget {
  const CategoriesItemsPage({
    Key? key,
    required this.pageIndex,
    this.isBreakfast = false,
    this.isDinner = false,
    this.isSnack = false,
    this.isDrink = false,
    this.isDessert = false,
  }) : super(key: key);
  final int pageIndex;
  final bool isBreakfast;
  final bool isDinner;
  final bool isSnack;
  final bool isDrink;
  final bool isDessert;

  @override
  State<CategoriesItemsPage> createState() => _CategoriesItemsPageState();
}

class _CategoriesItemsPageState extends State<CategoriesItemsPage> {
  List<String> getSelectedImages() {
    if (widget.isBreakfast) {
      return breakfastImages;
    } else if (widget.isSnack) {
      return snacksImages;
    } else if (widget.isDinner) {
      return dinnerImages;
    } else if (widget.isDessert) {
      return dessertImages;
    } else {
      return [];
    }
  }

  List<String> getSelectedNames() {
    if (widget.isBreakfast) {
      return breakfastNames;
    } else if (widget.isSnack) {
      return snacksNames;
    } else if (widget.isDinner) {
      return dinnerNames;
    } else if (widget.isDessert) {
      return dessertNames;
    } else {
      return [];
    }
  }

  List<double> getSelectedPrice() {
    if (widget.isBreakfast) {
      return breakfastPrice;
    } else if (widget.isSnack) {
      return snacksPrice;
    } else if (widget.isDinner) {
      return dinnerPrice;
    } else if (widget.isDessert) {
      return dessertPrice;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> selectedImages = getSelectedImages();
    List<String> selectedNames = getSelectedNames();
    List<double> selectedPrice = getSelectedPrice();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                widget.isDrink
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(Dimensions.heightFor10),
                            child: Container(
                              width: Dimensions.screenWidth,
                              height: Dimensions.heightFor60 * 0.9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                  child: TextSize(
                                text: 'tea'.toUpperCase(),
                                size: Dimensions.font26,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                              )),
                            ),
                          ),
                          GridViewPage(
                            itemImage: TeaImages,
                            itemName: teaNames,
                            itemPrice: teaPrice,
                            pageIndex: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimensions.heightFor10),
                            child: Container(
                              width: Dimensions.screenWidth,
                              height: Dimensions.heightFor60 * 0.9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                  child: TextSize(
                                text: 'coffee'.toUpperCase(),
                                size: Dimensions.font26,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                              )),
                            ),
                          ),
                          GridViewPage(
                            itemImage: CoffeeImages,
                            itemName: coffeeNames,
                            itemPrice: coffeePrice,
                            pageIndex:1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(Dimensions.heightFor10),
                            child: Container(
                              width: Dimensions.screenWidth,
                              height: Dimensions.heightFor60 * 0.9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: Colors.grey[300],
                              ),
                              child: Center(
                                  child: TextSize(
                                text: 'cold drinks'.toUpperCase(),
                                size: Dimensions.font26,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan,
                              )),
                            ),
                          ),
                          GridViewPage(
                            itemImage: drinkImages,
                            itemName: drinkNames,
                            itemPrice: drinkPrice,
                            pageIndex: 2,
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(Dimensions.heightFor10),
                              child: Container(
                                width: Dimensions.screenWidth,
                                height: Dimensions.heightFor60 * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: Colors.grey[300],
                                ),
                                child: Center(
                                  child: widget.isBreakfast
                                      ? TextSize(
                                          text: 'Breakfasts'.toUpperCase(),
                                          size: Dimensions.font26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.cyan,
                                        )
                                      : widget.isSnack
                                          ? TextSize(
                                              text:
                                                  'Snacks/Lunch'.toUpperCase(),
                                              size: Dimensions.font26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan,
                                            )
                                          : widget.isDinner
                                              ? TextSize(
                                                  text: 'Dinner'.toUpperCase(),
                                                  size: Dimensions.font26,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan,
                                                )
                                              : TextSize(
                                                  text:
                                                      'Desserts'.toUpperCase(),
                                                  size: Dimensions.font26,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan,
                                                ),
                                ),
                              ),
                            ),
                            GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.all(Dimensions.heightFor15),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                              ),
                              itemCount: selectedImages.length,
                              itemBuilder: (context, index) {
                                String image = selectedImages[index];
                                String name = selectedNames[index];
                                double price = selectedPrice[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RecommendedFood(
                                          pageIndex: widget.pageIndex + 1,
                                          image: selectedImages[index],
                                          name: selectedNames[index],
                                          price: selectedPrice[index],
                                          category: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: Dimensions.ListViewImage,
                                    height: Dimensions.ListViewImage,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.red,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFFe8e8e8),
                                          blurRadius: 5,
                                          offset: Offset(0, 5),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(-5, 0),
                                        ),
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(5, 0),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        image: AssetImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          color: Colors.black.withOpacity(0.6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SmallTextSize(
                                                size: Dimensions.font24 * 0.7,
                                                color: Colors.white,
                                                text: name,
                                              ),
                                              SizedBox(height: 4),
                                              SmallTextSize(
                                                size: Dimensions.font24 * 0.7,
                                                color: Colors.white,
                                                text: "Rs.${price.toString()}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                Positioned(
                    top: Dimensions.heightFor10,
                    left: Dimensions.heightFor10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.heightFor10 / 2),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.grey,
                          ),
                          child: AppIcons(
                            icon: Icons.clear,
                            iconColor: Colors.black,
                            iconSize: Dimensions.font26,
                            size: Dimensions.heightFor60 / 1.5,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
