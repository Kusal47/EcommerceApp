import 'package:esewa_flutter/esewa_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Dimension/height_width.dart';
import '../Cart Page/cart.dart';

class EsewaApp extends StatefulWidget {
  const EsewaApp({
    Key? key,
    this.price,
    this.productId,
    this.isTotalAmt = false,
  }) : super(key: key);
  final double? price;
  final int? productId;
  final bool isTotalAmt;
  @override
  State<EsewaApp> createState() => _EsewaAppState();
}

class _EsewaAppState extends State<EsewaApp> {
  String refId = '';
  String hasError = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () async {
              final result = await Esewa.i.init(
                context: context,
                eSewaConfig: ESewaConfig.dev(
                  // .live for live
                  su: 'https://www.marvel.com/hello',
                  amt: widget.price!,
                  fu: 'https://www.marvel.com/hello',
                  pid: widget.productId.toString(),
                  serverUrl: 'https://uat.esewa.com.np/epay/main?',
                  // scd: 'EPAYTEST'
                ),
              );
              if (result.hasData) {
                final response = result.data!;
                if (kDebugMode) {
                  print(response.toJson());
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
                } else {
                  if (kDebugMode) {
                    print(result.error);
                  }
                }
              }
              ;
            },
            child: Container(
              height: Dimensions.heightFor60,
              width: Dimensions.widthFor110,
              child: Image.asset(
                'assets/image/esewa.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (refId.isNotEmpty)
            Text('Console: Payment Success, Ref Id: $refId'),
          if (hasError.isNotEmpty)
            Text('Console: Payment Failed, Message: $hasError'),
        ],
      ),
    );
  }
}
