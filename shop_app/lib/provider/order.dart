import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/widgets/snackbars.dart';
import 'cart.dart';

// ignore: camel_case_types
class Prov_Orders with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  addOrder(double total, List<CartItem> cartItems, BuildContext context) async {
    const url = "https://shopapp-79aa6-default-rtdb.firebaseio.com/orders.json";
    final uri = Uri.parse(url);

    try {
      final res = await http.post(uri,
          body: json.encode({
            "id": DateTime.now().toString(),
            "dataTime": DateFormat("dd-mm-yyyy hh:mm")
                .format(DateTime.now())
                .toString(),
            "price": "$total",
            "products": json.encode(cartItems.toList())
          }));
    } catch (e) {
      print("Error:$e , CartItems: $cartItems");
      MySnackBars.errorSnackBar(context, e.toString());
      return;
    }

    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            dataTime: DateFormat("dd-mm-yyyy hh:mm")
                .format(DateTime.now())
                .toString(),
            price: total,
            products: cartItems));

    MySnackBars.successSnackBar(context, text: "Thanks for placing your Order");
    notifyListeners();
  }
}
