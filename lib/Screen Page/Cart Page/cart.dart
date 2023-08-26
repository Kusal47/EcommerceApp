import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartItem {
  final int pageId;
  final String title;
  final double price;
  final int quantity;
 DateTime? timestamp;

  CartItem({
    required this.pageId,
    required this.title,
    required this.price,
    required this.quantity,
    this.timestamp,
  });
    Map<String, dynamic> toJson() {
    return {
      'pageId': pageId,
      'title': title,
      'price': price,
      'quantity': quantity,
      'timestamp': timestamp!.toIso8601String(), // Convert timestamp to a string
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      pageId: json['pageId'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      timestamp: DateTime.parse(json['timestamp']), // Parse the stored string back to a DateTime
    );
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
    static const _cartKey = 'cart_data';

  Future<void> saveCartToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _items.map((key, cartItem) => MapEntry(key, cartItem.toJson()));
    await prefs.setString(_cartKey, json.encode(cartData));
  }

  Future<void> loadCartFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(_cartKey);
    if (cartData != null) {
      final decodedData = json.decode(cartData) as Map<String, dynamic>;
      _items = decodedData.map((key, value) => MapEntry(key, CartItem.fromJson(value)));
      notifyListeners();
    }
  }

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  // void addItem(
  //   int pageId,
  //   String title,
  //   double price,
  //   int quantity,
  // ) {
  //   if (_items.containsKey(pageId.toString())) {
  //     updateQuantity(pageId, title, price, quantity);
  //   } else {
  //     _items.putIfAbsent(
  //       pageId.toString(),
  //       () => CartItem(
  //         pageId: pageId,
  //         title: title,
  //         price: price,
  //         quantity: quantity,
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }
void addItem(
  int pageId,
  String title,
  double price,
  int quantity,
) {
  final now = DateTime.now();
  if (_items.containsKey(pageId.toString())) {
    updateQuantity(pageId, title, price, quantity);
  } else {
    _items.putIfAbsent(
      pageId.toString(),
      () => CartItem(
        pageId: pageId,
        title: title,
        price: price,
        quantity: quantity,
        timestamp: now,
      ),
    );
  }
  notifyListeners();
}

  void updateQuantity(
    int pageId,
    String title,
    double price,
    int quantity,
  ) {
    _items.update(
      pageId.toString(),
      (existingCartItem) => CartItem(
        pageId: existingCartItem.pageId,
        title: existingCartItem.title,
        price: existingCartItem.price,
        quantity: existingCartItem.quantity != 0
            ? existingCartItem.quantity + quantity
            : quantity,
      ),
    );
    notifyListeners();
  }

  // void addQuantity(
  //   int pageId,
  //   int quantity,
  // ) {
  //   if (quantity < 0) {
  //     quantity = 1;
  //   } else {
  //     _items.update(
  //       pageId.toString(),
  //       (existingCartItem) => CartItem(
  //         pageId: existingCartItem.pageId,
  //         title: existingCartItem.title,
  //         price: existingCartItem.price,
  //         quantity: quantity,
  //       ),
  //     );
  //     notifyListeners();
  //   }
  // }
  void addQuantity(
    int pageId,
    int quantity,
  ) {
    if (quantity < 0) {
      quantity = 1;
    } else {
      _items.update(
        pageId.toString(),
        (existingCartItem) => CartItem(
          pageId: existingCartItem.pageId,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: quantity,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(
    int page,
  ) {
    _items.remove(page.toString());
    notifyListeners();
  }

  void removeItembyname(
    String title,
  ) {
    _items.remove(title.toString());
    notifyListeners();
  }

  Future<void> clearCartAndDeleteOrders() async {
    final items = _items.values.toList();
    for (final item in items) {
      deleteOrder(
          item.title); // Assuming 'title' is the field that identifies the item
    }
    deleteAllItems();

    _items = {}; // Clear the cart
    notifyListeners();
  }

  void deleteOrder(String itemName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final orderCollection =
          FirebaseFirestore.instance.collection('Order_$userId');
      final orderSnapshot =
          await orderCollection.where('name', isEqualTo: itemName).get();

      if (orderSnapshot.docs.isNotEmpty) {
        // Delete the order documents with matching item name
        for (final orderDoc in orderSnapshot.docs) {
          await orderDoc.reference.delete();
        }
        print('Order deleted successfully.');
      }
    }
  }

  void deleteAllItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final orderCollection =
          FirebaseFirestore.instance.collection('Order_$userId');

      final querySnapshot = await orderCollection.get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('All items deleted from Firestore.');
    }
  }

  Future<Map<String, CartItem>> loadCartItemsFromFirestore() async {
  final user = FirebaseAuth.instance.currentUser;
  final cartItems = <String, CartItem>{};

  if (user != null) {
    final userId = user.uid;
    final orderCollection = FirebaseFirestore.instance.collection('Order_$userId');
    
    final orderSnapshot = await orderCollection.get();
    for (final doc in orderSnapshot.docs) {
      final name = doc['name'] as String;
      final price = doc['price'] as double;
      final quantity = doc['quantity'] as int;

      cartItems[name] = CartItem(
        pageId: 0, // You can set this value as needed
        title: name,
        price: price,
        quantity: quantity,
      );
    }
  }

  return cartItems;
}

}
