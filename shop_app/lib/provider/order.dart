import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'cart.dart';

class OrderItem {
  String id;
  String dataTime;
  double price;
  List<CartItem> products;

  OrderItem(
      {required this.id,
      required this.dataTime,
      required this.price,
      required this.products});
}

// ignore: camel_case_types
class Prov_Orders with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  addOrder(double total, List<CartItem> cartItems) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            dataTime: DateFormat("dd-mm-yyyy hh:mm")
                .format(DateTime.now())
                .toString(),
            price: total,
            products: cartItems));
    notifyListeners();
  }
}
