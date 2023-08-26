import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Dimension/height_width.dart';
import '../../Services/order_service.dart';
import '../../Widgets/elevated_button.dart';
import '../../Widgets/icons.dart';
import '../../Widgets/large_font.dart';
import 'cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
    this.onItemCancelled,
  }) : super(key: key);
  final void Function()? onItemCancelled;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
   Cart cart = Cart();
  Map<String, CartItem> cartItems = {};

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    await cart.loadCartFromSharedPreferences();
    setState(() {
      cartItems = cart.items;
    });
  }

  Future<void> updateCart() async {
    // Update the cart as needed
    // ...
    await cart.saveCartToSharedPreferences();
    setState(() {
      cartItems = cart.items;
    });
  }

  Widget build(BuildContext context) {
    // Access the Cart instance using Provider
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    Future<void> fetchItemDetails() async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final orderCollection =
            FirebaseFirestore.instance.collection('Order_$userId');

        for (final item in items) {
          final itemTitle = item.title;
          final orderSnapshot =
              await orderCollection.where('name', isEqualTo: itemTitle).get();

          if (orderSnapshot.docs.isNotEmpty) {
            final itemDocument = orderSnapshot.docs.first;
            final itemData = itemDocument.data();
            final itemPrice = itemData['price']
                as double; // Adjust this field name based on your Firestore structure

            print(
                'Item: $itemTitle, Price: $itemPrice, Quantity: ${item.quantity}');
          }
        }
      }
    }

    fetchItemDetails();
    // Function to add order to Firestore
    Future<void> addOrder(
        int quantity, String itemNames, double price, bool isDecrease) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        OrderService()
            .updateOrder(userId, itemNames, quantity, price, true, isDecrease);
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Dimensions.heightFor60 - 5,
        elevation: 0,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextSize(
              text: 'My Cart',
              color: Colors.black,
              size: Dimensions.font26,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Item Clear'),
                    content: Text(
                        'All the items in cart will be cleared. Do you want to clear?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Clear the cart and delete orders
                          cart.clearCartAndDeleteOrders();
                          Navigator.pop(context);
                          print('All Items Cleared!!!');
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                );
              },
              child: TextSize(
                text: 'Clear All',
                color: Colors.black,
                size: Dimensions.font16,
              ),
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () {
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => FoodPage()));
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
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item =
                    items[index]; // Access the item at the current index
                return Container(
                  padding: EdgeInsets.all(Dimensions.heightFor10),
                  margin: EdgeInsets.only(
                    left: Dimensions.widthFor10,
                    right: Dimensions.widthFor10,
                    top: Dimensions.heightFor10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.radius20 / 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextSize(
                                text: item.title,
                                color: Colors.black87,
                                size: Dimensions.font20,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: Dimensions.widthFor5,
                              ),
                              Container(
                                child: TextSize(
                                  text: '\$${item.price} /per',
                                  color: Colors.black87,
                                  size: Dimensions.font20,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: Dimensions.heightFor30 * 3,
                                height: Dimensions.heightFor30 * 1.2,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[200],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20 / 2),
                                ),
                                child: Center(
                                  child: TextSize(
                                    text: '\$ ${item.price * item.quantity}',
                                    size: Dimensions.heightFor20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.heightFor10,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        cart.addQuantity(
                                          item.pageId,
                                          item.quantity - 1,
                                        );
                                      });
                                      await addOrder(item.quantity, item.title,
                                          item.price, true);
                                    },
                                    child: AppIcons(
                                      icon: Icons.remove,
                                      bgColor: Colors.red,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.font20,
                                      size: Dimensions.heightFor20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthFor10 / 2,
                                  ),
                                  TextSize(
                                    text: '${item.quantity}',
                                    size: Dimensions.font20,
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthFor10 / 2,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        if (item.quantity < 20) {
                                          cart.addQuantity(
                                            item.pageId,
                                            item.quantity + 1,
                                          );
                                        }
                                      });
                                      await addOrder(item.quantity, item.title,
                                          item.price, false);
                                    },
                                    child: AppIcons(
                                      icon: Icons.add,
                                      bgColor: Colors.green,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.font20,
                                      size: Dimensions.heightFor20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.heightFor10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Button to cancel order
                          ButtonElevated(
                            bgColor: Colors.red,
                            text1: 'Cancel Order',
                            text2: 'Are you sure you want to cancel order?',
                            text3: 'Yes',
                            text4: 'No',
                            text5: 'Cancel Order',
                            isCancel: true,
                            onPressed1: () {
                              setState(() {
                                Navigator.pop(context);
                                cart.removeItem(item.pageId);
                                widget.onItemCancelled!();
                                cart.deleteOrder(item.title);
                                print('Order deleted successfully.');
                              });
                            },
                            onPressed2: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          ),
                          // Button to make payment
                          ButtonElevated(
                            price: item.price * item.quantity,
                            productId: item.pageId,
                            bgColor: Colors.blue,
                            text1: 'Make Payment',
                            text2: 'Payment Methods',
                            text3: 'Close',
                            text4: 'Please add quantity to make payment',
                            text5: 'Ok',
                            text6: 'Payment Error',
                            quantity: item.quantity,
                            isPayment: true,
                            onPressed1: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Total amount section
          Container(
            height: Dimensions.heightFor70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius15),
                topRight: Radius.circular(Dimensions.radius15),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.widthFor10),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.widthFor5,
                      ),
                      Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  // Button to checkout
                  if (items
                      .isNotEmpty) // Only display the button when items are present
                    ButtonElevated(
                      price: cart.totalAmount,
                      productId: items[0].pageId,
                      isTotalAmt: true,
                      bgColor: Colors.green,
                      text1: 'Checkout All',
                      text2: 'Payment Methods',
                      text3: 'Close',
                      text4: 'Please add quantity to make payment',
                      text5: 'Ok',
                      text6: 'Payment Error ',
                      quantity: items[0].quantity,
                      isPayment: true,
                      onPressed1: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
