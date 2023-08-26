import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> updateOrder(String userId, String name, int quantity,
      double price, bool isCart, bool isDecrease) async {
    final orderCollection =
        FirebaseFirestore.instance.collection('Order_$userId');
    final existingOrderSnapshot =
        await orderCollection.where('name', isEqualTo: name).limit(1).get();
    if (isCart) {
      if (existingOrderSnapshot.docs.isNotEmpty) {
        // Update the existing order's quantity and price
        final existingOrderDoc = existingOrderSnapshot.docs.first;
        final existingQuantity = existingOrderDoc['quantity'];
        final existingPrice = existingOrderDoc['price'];

        await existingOrderDoc.reference.update({
          'quantity': isDecrease ? existingQuantity - 1 : existingQuantity + 1,
          'price': isDecrease ? existingPrice - price : existingPrice + price,
        });

        print('Order updated successfully.');
      }
    } else if (existingOrderSnapshot.docs.isNotEmpty) {
      // Update the existing order's quantity and price
      final existingOrderDoc = existingOrderSnapshot.docs.first;
      final existingQuantity = existingOrderDoc['quantity'];
      final existingPrice = existingOrderDoc['price'];

      await existingOrderDoc.reference.update({
        'quantity': existingQuantity + quantity,
        'price': existingPrice + (price * quantity),
      });

      print('Order updated successfully.');
    } else {
      // Add a new order
      await orderCollection.add({
        'name': name,
        'price': price * quantity,
        'quantity': quantity,
      });

      print('New order added successfully.');
    }
  }

}
