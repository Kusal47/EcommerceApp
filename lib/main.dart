import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';
import 'Screen Page/Cart Page/cart.dart';
import 'Screen Page/Home/loading_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Cart(),
        child: KhaltiScope(
            publicKey: 'test_public_key_d5d9f63743584dc38753056b0cc737d5',
            enabledDebugging: true,
            builder: (context, navKey) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'E-Commerce App',
                home: const Loading(),
                navigatorKey: navKey,
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
              );
            }));
  }
}
