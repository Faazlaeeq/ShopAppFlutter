import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': title,
      'quantity': quantity,
      'price': price,
    };
  }
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  String get itemsCount {
    int qty = 0;
    _items.forEach((key, value) {
      qty += value.quantity;
    });
    return qty.toString();
  }

  void addItem(String productId, String title, double price) {
    if (items.containsKey(productId)) {
      _items.update(
          productId,
          (old) => CartItem(
              id: productId,
              title: old.title,
              price: old.price,
              quantity: old.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  double get totalCount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity * value.price;
    });
    return total;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
