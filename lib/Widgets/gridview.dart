import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Widgets/small_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Dimension/height_width.dart';
import '../Screen Page/Cart Page/cart.dart';
import '../Screen Page/Cart Page/cart_page.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemImage,
      required this.pageIndex});
  final int pageIndex;
  final List<String> itemName;
  final List<double> itemPrice;
  final List<String> itemImage;

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  onItemCancelled() {
    setState(() {
      final cart = Provider.of<Cart>(context, listen: false);
      if (widget.pageIndex == 0) {
        widget.itemName.forEach((itemName) {
          cart.removeItembyname(itemName);
        });
      } else {
        cart.removeItem(widget.pageIndex);
      }
    });
  }

  addOrder(int quantity, String itemNames, double price) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final orderCollection =
          FirebaseFirestore.instance.collection('Order_$userId');
      final existingOrderSnapshot = await orderCollection
          .where('name', isEqualTo: itemNames)
          .limit(1)
          .get();

      if (existingOrderSnapshot.docs.isNotEmpty) {
        // Update the existing order's quantity and price
        final existingOrderDoc = existingOrderSnapshot.docs.last;
        final existingQuantity = existingOrderDoc['quantity'];
        final existingPrice = existingOrderDoc['price'];

        existingOrderDoc.reference.update({
          'quantity': existingQuantity + quantity,
          'price': existingPrice + (price * quantity),
        });

        print('Order updated successfully.');
      } else {
        // Add a new order
        await orderCollection.add({
          'name': itemNames,
          'price': price * quantity,
          'quantity': quantity,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(Dimensions.heightFor15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        crossAxisCount: 2,
      ),
      itemCount: widget.itemName.length,
      itemBuilder: (_, indx) {
        return InkWell(
          onTap: () async {
            final cart = Provider.of<Cart>(context, listen: false);

            cart.addItem(widget.pageIndex, widget.itemName[indx],
                widget.itemPrice[indx], 1);

            addOrder(1, widget.itemName[indx], widget.itemPrice[indx]);
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CartPage(onItemCancelled: onItemCancelled)),
            );
            print('${widget.itemName} added to cart.');
          },
          child: Container(
            width: Dimensions.ListViewImage,
            height: Dimensions.ListViewImage,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.red,
              image: DecorationImage(
                image: AssetImage(widget.itemImage[indx]),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmallTextSize(
                        size: Dimensions.font24 * 0.7,
                        color: Colors.white,
                        text: widget.itemName[indx],
                      ),
                      SizedBox(height: 4),
                      SmallTextSize(
                        size: Dimensions.font24 * 0.7,
                        color: Colors.white,
                        text: 'Rs.${widget.itemPrice[indx].toString()}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
