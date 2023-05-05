import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = <Product>[];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorateItems {
    return (items.where((element) => element.isFavorate == true)).toList();
  }

  Future<void> getItems() async {
    try {
      final url = Uri.parse(
          'https://shopapp-79aa6-default-rtdb.firebaseio.com/products.json');

      final data = await http.get(url);
      final extractedData = json.decode(data.body) as Map<String, dynamic>;
      var _loadedData = <Product>[];
      extractedData.forEach((key, value) {
        _loadedData.add(Product(
            title: value['title'],
            id: key,
            description: value["desc"],
            imageUrl: value["imgUrl"],
            price: double.parse(value["price"]),
            isFavorate: value["isFavorate"] ?? false));
      });

      _items = _loadedData;
      print("all done");
      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
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
              "price": p.price.toString(),
              "isFavorate": p.isFavorate
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

  Future<void> updateProduct(String id, Product p) async {
    print(p.title);
    if (id == null || id == "") {
      return;
    } else {
      final url = Uri.parse(
          'https://shopapp-79aa6-default-rtdb.firebaseio.com/products/$id.json');
      await http.patch(url,
          body: jsonEncode({
            "title": p.title,
            "desc": p.description,
            "imgUrl": p.imageUrl,
            "price": p.price.toString()
          }));

      var index = _items.indexWhere((element) => (element.id == p.id));
      _items[index] = p;
    }
    notifyListeners();
  }

  void deleteProduct(String id) {
    final url = Uri.parse(
        'https://shopapp-79aa6-default-rtdb.firebaseio.com/products/$id.json');

    var index = _items.indexWhere((element) => (element.id == id));

    var existingItem = _items[index];
    http.delete(url).catchError((_) {
      _items.insert(index, existingItem);
      notifyListeners();
    });

    _items.removeWhere((element) => (element.id == id));
    notifyListeners();
  }
}
