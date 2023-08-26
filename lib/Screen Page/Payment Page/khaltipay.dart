import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

import '../../Dimension/height_width.dart';
import '../Cart Page/cart.dart';
import '../Cart Page/cart_page.dart';

class KhaltiApp extends StatefulWidget {
  const KhaltiApp(
      {super.key, this.price, this.productId, this.isTotalAmt = false});
  final double? price;
  final int? productId;
  final bool isTotalAmt;
  @override
  State<KhaltiApp> createState() => _KhaltiAppState();
}

class _KhaltiAppState extends State<KhaltiApp> {
  String referenceId = '';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        payKhalti();
      },
      child: Container(
        height: Dimensions.heightFor60,
        width: Dimensions.widthFor110,
        child: Image.asset(
          'assets/image/Khalti.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  payKhalti() {
    KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: widget.price!.toInt() * 100,
          productIdentity: widget.productId.toString(),
          productName: 'Product Name',
          mobile: '9840454804',
          mobileReadOnly: true,
        ),
        preferences: [PaymentPreference.khalti],
        onSuccess: onSuccess,
        onFailure: onFailure,
        onCancel: onCancel);
  }

  void onSuccess(PaymentSuccessModel success) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Payment Success'),
              content: Text('Reference Id: ${success.idx}'),
              actions: [
                InkWell(
                    onTap: () {
                      setState(() {
                        referenceId = success.idx;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                      final cart = Provider.of<Cart>(context, listen: false);
                      final items = cart.items.values.toList();
                      if (items.isNotEmpty) {
                        for (int i = 0; i < items.length; i++) {
                          if (widget.isTotalAmt) {
                            cart.clearCartAndDeleteOrders();
                          } else {
                            cart.removeItem(items[i].pageId);
                          }
                        }
                      }
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  void onFailure(PaymentFailureModel failure) {
    debugPrint(failure.toString());
  }

  void onCancel() {
    debugPrint('Cancelled');
  }
}
