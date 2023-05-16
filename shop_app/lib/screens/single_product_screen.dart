import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';

class SingleProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
        appBar: AppBar(
          title: Text(loadedProduct.title),
        ),
        body: Card(
          child: Column(children: [
            Image.network(loadedProduct.imageUrl),
            Text(
              "\$${loadedProduct.price.toString()}",
              style: TextStyle(fontSize: 26),
            ),
          ]),
        ));
  }
}
