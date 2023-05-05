import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/product_items.dart';

import '../provider/products.dart';

class ProductGrid extends StatelessWidget {
  final bool isFavorate;

  ProductGrid({required this.isFavorate});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productItem =
        isFavorate ? productsData.favorateItems : productsData.items;
    print("grid ran");
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: productItem.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: productItem[i], child: ProductItem()),
    );
  }
}
