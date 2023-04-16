import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/productsList.dart';

import '../provider/products.dart';

class UserProducts extends StatelessWidget {
  const UserProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context).items;

    return Scaffold(
        drawer: DrawerWid(),
        appBar: AppBar(
          title: const Text("Manage Products"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.addProducts),
                ))
          ],
        ),
        body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductsList(products[i].id,
                products[i].title, products[i].price, products[i].imageUrl)));
  }
}
