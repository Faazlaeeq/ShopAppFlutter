import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/order.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/add_product.dart';
import 'package:shop_app/screens/checkout_screen.dart';
import 'package:shop_app/screens/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview.dart';
import 'package:shop_app/screens/signup.dart';
import 'package:shop_app/screens/single_product_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import 'package:shop_app/theme/themedata.dart';

void main() async {
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeSettings theme = ThemeSettings();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Prov_Orders()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: theme.darkTheme,
          home: const AuthScreen(),
          routes: {
            Routes.login: (ctx) => const AuthScreen(),
            Routes.signup: (ctx) => const SignupScreen(),
            Routes.productsOverview: (ctx) => ProductOverview(),
            Routes.singleProduct: (ctx) => SingleProduct(),
            Routes.checkout: (ctx) => CheckOut(),
            Routes.orders: (ctx) => Orders(),
            Routes.userProducts: (ctx) => const UserProducts(),
            Routes.addProducts: (ctx) => const AddProduct(),
          },
        ));
  }
}
