import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final List<Product> _items = <Product>[
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg",
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorateItems {
    return (items.where((element) => element.isFavorate == true)).toList();
  }

  Future<void> additem(Product p) {
    p = Product(
        id: DateTime.now().toString(),
        title: p.title,
        description: p.description,
        price: p.price,
        imageUrl: p.imageUrl);
    final url = Uri.https(
        'shopapp-79aa6-default-rtdb.firebaseio.com', '/products.json');

    return http
        .post(url,
            body: json.encode({
              "title": p.title,
              "desc": p.description,
              "imgUrl": p.imageUrl,
              "price": p.price.toString()
            }))
        .then((value) {
      if (value.statusCode == 200) {
        _items.add(p);
        notifyListeners();
      } else {
        return Future.error(value.body);
      }
    }).catchError((onError) {
      return onError;
    });
  }

  Product findById(id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateProduct(String id, Product p) {
    print(p.title);
    if (id == null || id == "") {
      return;
    } else {
      final url = Uri.https(
          'shopapp-79aa6-default-rtdb.firebaseio.com', '/products.json');
      http
          .post(url,
              body: jsonEncode({
                "title": p.title,
                "desc": p.description,
                "imgUrl": p.imageUrl,
                "price": p.price.toString()
              }))
          .then((res) {
        print(jsonDecode(res.body));
        var index = _items.indexWhere((element) => (element.id == p.id));
        _items[index] = p;
      });
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => (element.id == id));
    notifyListeners();
  }
}
