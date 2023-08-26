import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Dimension/food_items_list.dart';
import '../../../Dimension/height_width.dart';
import '../../../Services/order_service.dart';
import '../../../Widgets/expandable_text.dart';
import '../../../Widgets/food_price.dart';
import '../../../Widgets/icons.dart';
import '../../../Widgets/large_font.dart';
import '../../../Widgets/recommend_food_price.dart';
import '../../Cart Page/cart.dart';
import '../../Cart Page/cart_page.dart';

class RecommendedFood extends StatefulWidget {
  const RecommendedFood({
    Key? key,
    required this.pageIndex,
    this.image,
    this.name,
    this.price = 0,
    this.category = false,
  }) : super(key: key);
  final int pageIndex;
  final String? image;
  final String? name;
  final double? price;
  final bool category;

  @override
  State<RecommendedFood> createState() => _RecommendedFoodState();
}

class _RecommendedFoodState extends State<RecommendedFood> {
  int quantity = 0;
  int cartCount = 0;

  void setQuantity(bool isIncrements) {
    if (isIncrements) {
      quantity = checkQuantity(quantity + 1);
    } else {
      quantity = checkQuantity(quantity - 1);
    }
  }

  int checkQuantity(int quantity) {
    if (quantity == 10) {
      Get.snackbar(
        'Limit Error',
        'You can\'t add more than 10 items',
        backgroundColor: Colors.white,
        barBlur: 20,
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: 3),
        isDismissible: true,
        dismissDirection: DismissDirection.startToEnd,
        padding: EdgeInsets.all(Dimensions.heightFor20),
      );
      return 10;
    } else if (quantity < 0) {
      return 1;
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
        cartCount = cartCount + quantity;
        if (cartCount > 20) {
          cartCount = 20;

          Get.snackbar(
            'Limit Error',
            'You can\'t add the same item more than 10 times',
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
    });
    Get.snackbar(
      'Item Added',
      '${cartCount}  ${widget.category ? widget.name! : foodNames[widget.pageIndex]}  added to cart',
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

    widget.category
        ? cart.addItem(widget.pageIndex, widget.name!, widget.price!, quantity)
        : cart.addItem(widget.pageIndex, foodNames[widget.pageIndex],
            foodPrice[widget.pageIndex], quantity);
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      OrderService().updateOrder(
          userId,
          widget.category ? widget.name! : foodNames[widget.pageIndex],
          quantity,
          widget.category
              ? widget.price!
              : foodPrice[widget.pageIndex] * quantity,
          false,
          false);
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
    final cart = Provider.of<Cart>(context, listen: false);
    final items = cart.items;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Dimensions.heightFor70,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: AppIcons(
                icon: Icons.clear,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (cartCount != 0 || items.length != 0) {
                    if (quantity == 0) {
                      return null;
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
              child: Stack(children: [
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              cartCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            )),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          )),
              ]),
            ),
          ]),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Container(
              child: Center(
                  child: TextSize(
                      text: widget.category
                          ? widget.name!
                          : foodNames[widget.pageIndex],
                      size: Dimensions.font26)),
              width: double.maxFinite,
              padding: EdgeInsets.only(bottom: 10, top: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
              ),
            ),
          ),
          pinned: true,
          backgroundColor: Colors.red,
          expandedHeight: 450,
          flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
            widget.category
                ? widget.image!
                : imageList[widget.pageIndex].toString(),
            width: double.maxFinite,
            fit: BoxFit.cover,
          )),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.widthFor20,
                      right: Dimensions.widthFor20),
                  child: ExpandableText(
                    text: widget.category
                        ? ''
                        : descriptionText[widget.pageIndex],
                  ))
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.heightFor20,
                  bottom: Dimensions.heightFor20,
                  left: Dimensions.heightFor20,
                  right: Dimensions.heightFor20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                // color: Colors.grey[400]
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setQuantity(false);
                        });
                      },
                      child: AppIcons(
                        icon: Icons.remove,
                        bgColor: Colors.red,
                        iconColor: Colors.white,
                        iconSize: Dimensions.font26,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.widthFor10 / 2,
                    ),
                    Row(
                      children: [
                        Container(
                            child: RecommendFoodPrice(
                          text: widget.category
                              ? widget.price!.toString()
                              : foodPrice[widget.pageIndex].toString(),
                        )),
                        TextSize(text: '$quantity', size: Dimensions.font26),
                      ],
                    ),
                    SizedBox(
                      width: Dimensions.widthFor10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setQuantity(true);
                        });
                      },
                      child: AppIcons(
                        icon: Icons.add,
                        bgColor: Colors.green,
                        iconColor: Colors.white,
                        iconSize: Dimensions.font26,
                      ),
                    )
                  ]),
            ),
            Container(
              // color: Colors.blue,
              padding: EdgeInsets.only(
                  top: Dimensions.heightFor20,
                  bottom: Dimensions.heightFor20,
                  left: Dimensions.widthFor30,
                  right: Dimensions.widthFor30),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: () {
                    quantityItem();
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.heightFor20,
                          bottom: Dimensions.heightFor20,
                          left: Dimensions.heightFor20,
                          right: Dimensions.heightFor20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Color.fromARGB(255, 12, 235, 12),
                      ),
                      child: FoodPrice(
                        text: widget.category
                            ? widget.price!.toString()
                            : foodPrice[widget.pageIndex].toString(),
                      )),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
