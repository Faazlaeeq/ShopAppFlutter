import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/product_items.dart';

enum FilterOptions { favoriteOnly, showAll }

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _showFavorate = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        drawer: const DrawerWid(),
        appBar: AppBar(title: const Text("The Shop"), actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.showAll) {
                  _showFavorate = false;
                } else {
                  _showFavorate = true;
                }
              });
            },
            child: Icon(Icons.more_vert),
            itemBuilder: (_) =>const [
              PopupMenuItem(
                value: FilterOptions.favoriteOnly,
                child:Text("Show Favorites Only"),
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.showAll,
              )
            ],
          ),
          Consumer<Cart>(
            //Consumer builder(arg) take arguments as alias of other cosumer arguments which can be used in the function as names of argument defined below.
            //Like child argument given in builder function will to the child argument defined below in builder function.
            builder: (context, value, ch) =>Badge(child: ch,value: value.itemsCount,color: Colors.red,),
            child:
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {
                  Navigator.pushNamed(context, Routes.checkout);
                }),
          ),
        ]),
        body: ProductGrid(
          isFavorate: _showFavorate,
        ));
  }
}
