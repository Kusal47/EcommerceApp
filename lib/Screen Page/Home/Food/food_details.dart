import 'package:ecommerce_app/Services/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Dimension/food_items_list.dart';
import '../../../Dimension/height_width.dart';
import '../../../Widgets/food_detail_design.dart';
import '../../../Widgets/food_price.dart';
import '../../../Widgets/icons.dart';
import '../../../Widgets/large_font.dart';
import '../../Cart Page/cart_page.dart';
import '../../Cart Page/cart.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  final int pageIndex;

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  int quantity = 1;
  int cartCount = 0;

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      quantity = checkQuantity(quantity + 1);
    } else {
      quantity = checkQuantity(quantity - 1);
    }
  }

  int checkQuantity(int quantity) {
    if (quantity > 10) {
      return 10;
    } else if (quantity < 0) {
      return quantity = 1;
    } else {
      return quantity;
    }
  }

  void quantityItem() async {
    final cart = Provider.of<Cart>(context, listen: false);

    setState(() {
      if (checkQuantity(quantity + 1) == 1) {
        cartCount++;
      } else if (checkQuantity(quantity + 1) > 0) {
        cartCount = quantity;
        if (cartCount > 20) {
          cartCount = 20;

          Get.snackbar(
            'Limit Error',
            'You can\'t add same item more than 20 times',
            backgroundColor: Colors.white60,
            backgroundGradient:
                LinearGradient(colors: [Colors.red, Colors.blue]),
            colorText: Colors.white,
            barBlur: 20,
            snackStyle: SnackStyle.FLOATING,
            duration: Duration(seconds: 3),
            isDismissible: true,
            dismissDirection: DismissDirection.startToEnd,
            padding: EdgeInsets.all(Dimensions.heightFor20),
          );
        }
      }

      Get.snackbar(
        'Item Added',
        '${cartCount}  ${popularfoodNames[widget.pageIndex]}  added to cart',
        backgroundColor: Colors.white60,
        backgroundGradient: LinearGradient(colors: [Colors.red, Colors.blue]),
        colorText: Colors.white,
        barBlur: 20,
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.startToEnd,
        padding: EdgeInsets.all(Dimensions.heightFor20),
      );
    });
    
      cart.addItem(
        widget.pageIndex + 100,
        popularfoodNames[widget.pageIndex],
        popularfoodPrice[widget.pageIndex],
        quantity,
      );
    
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
     
       OrderService().updateOrder(userId, popularfoodNames[widget.pageIndex],
          quantity, popularfoodPrice[widget.pageIndex], false, false);
    
    
    }
  }

  onItemCancelled() {
    setState(() {
      quantity = 1;
      cartCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.foodDetailImageSize,
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                  image: AssetImage(popularImageList[widget.pageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Icon widgets
          Positioned(
            top: Dimensions.heightFor45,
            left: Dimensions.widthFor20,
            right: Dimensions.widthFor20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcons(
                    icon: Icons.arrow_back_ios,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      final cart = Provider.of<Cart>(context, listen: false);
                      final items = cart.items;
                      if (cartCount != 0 || items.length != 0) {
                        if (quantity == 0) {
                          return;
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartPage(
                                      onItemCancelled: onItemCancelled,
                                    )),
                          );
                        }
                      }
                    });
                  },
                  child: Stack(
                    children: [
                      AppIcons(
                        icon: Icons.shopping_cart,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: cartCount != 0
                            ? Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    cartCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Food details
          Container(
            child: FoodDetailDesign(
                index: widget.pageIndex,
                expandedText: descriptionText[widget.pageIndex],
                name: popularfoodNames[widget.pageIndex]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: Dimensions.heightFor30,
          horizontal: Dimensions.heightFor15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20 * 2),
            topRight: Radius.circular(Dimensions.radius20 * 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.heightFor20,
                horizontal: Dimensions.heightFor20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.grey[400],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setQuantity(false);
                      });
                    },
                    child: Icon(
                      Icons.remove,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.widthFor10 / 2,
                  ),
                  SizedBox(
                      width: Dimensions.widthFor20,
                      height: Dimensions.heightFor20,
                      child: TextSize(text: '$quantity')),
                  SizedBox(
                    width: Dimensions.widthFor10 / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setQuantity(true);
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                quantityItem();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.heightFor20,
                  horizontal: Dimensions.heightFor20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Color.fromARGB(255, 12, 235, 12),
                ),
                child: FoodPrice(
                    text: popularfoodPrice[widget.pageIndex].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
