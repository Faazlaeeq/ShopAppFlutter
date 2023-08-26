import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/product_grid.dart';

import '../widgets/badge.dart';

enum FilterOptions { favoriteOnly, showAll }

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _showFavorate = false;
  bool didLoadedOnce = false;
  bool loading = true;

  Future<void> loadProducts() async {
    setState(() {
      loading = true;
    });

    await Provider.of<Products>(context, listen: false)
        .getItems()
        .then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void didChangeDependencies() async {
    if (!didLoadedOnce) {
      Provider.of<Products>(context).getItems().then((value) {
        setState(() {
          loading = false;
        });
        didLoadedOnce = true;
      });
    }
    // didLoadedOnce = true;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWid(),
        appBar: AppBar(
            title: Center(
                child: Image.asset("assets/images/white-logo.png", height: 30)),
            actions: [
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
                child: const Icon(Icons.more_vert),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: FilterOptions.favoriteOnly,
                    child: Text("Show Favorites Only"),
                  ),
                  PopupMenuItem(
                    value: FilterOptions.showAll,
                    child: Text("Show All"),
                  )
                ],
              ),
              Consumer<Cart>(
                //Consumer builder(arg) take arguments as alias of other cosumer arguments which can be used in the function as names of argument defined below.
                //Like child argument given in builder function will to the child argument defined below in builder function.
                builder: (context, value, ch) {
                  return BadgeWid(
                    value: value.itemsCount,
                    color: Colors.red,
                    child: ch,
                  );
                },
                child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.checkout);
                    }),
              ),
            ]),
        body: RefreshIndicator(
          onRefresh: () => loadProducts(),
          child: loading
              ? Container(
                  child: const Center(child: CircularProgressIndicator()))
              : ProductGrid(
                  isFavorate: _showFavorate,
                ),
        ));
  }
}
