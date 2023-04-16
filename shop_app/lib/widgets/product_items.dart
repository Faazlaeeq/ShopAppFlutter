import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/routes.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.singleProduct,
                        arguments: product.id);
                  },
                  child: Text(product.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10))),
              leading: Consumer<Product>(
                builder: (ctx, _, child) => IconButton(
                    icon: Icon(product.isFavorate
                        ? Icons.favorite
                        : Icons.favorite_border),
                    onPressed: () {
                      product.toggleFavorate();
                    },
                    iconSize: 20),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price);
                },
                iconSize: 20,
              )),
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.singleProduct,
                    arguments: product.id);
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ))),
    );
  }
}
