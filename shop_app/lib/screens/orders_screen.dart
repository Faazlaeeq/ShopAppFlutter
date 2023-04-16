import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart' as ord;
import '../widgets/drawer.dart';
import '../widgets/order_item.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<ord.Prov_Orders>(context);
    final orderData = order.items;
    return Scaffold(
      drawer: DrawerWid(),

      appBar: AppBar(title: const Text("Your Orders")),
      body: ListView.builder(
          itemCount: orderData.length,
          itemBuilder: (ctx, i) =>
              OrderItem(orderData[i]),
    )
    );
  }
}
