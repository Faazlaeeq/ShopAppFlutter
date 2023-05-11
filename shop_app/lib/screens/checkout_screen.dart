import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart' show Cart;
import 'package:shop_app/routes.dart';
import '../provider/order.dart';
import '../widgets/cart_item.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Out"),
      ),
      body: Column(
        children: [
          Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                      label: Text(
                        "\$${cart.totalCount}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    TextButton(
                        onPressed: () {
                          Provider.of<Prov_Orders>(context, listen: false)
                              .addOrder(cart.totalCount,
                                  cart.items.values.toList(), context);
                          cart.clear();
                          Navigator.pushNamed(context, Routes.orders);
                        },
                        child: const Text("ORDER NOW"))
                  ],
                ),
              )),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItem(
              cart.items.values.toList()[i].id,
              cart.items.keys.toList()[i],
              cart.items.values.toList()[i].price,
              cart.items.values.toList()[i].title,
              cart.items.values.toList()[i].quantity,
            ),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}
