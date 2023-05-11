import 'package:flutter/material.dart';
import 'package:shop_app/models/order.dart' as ord;

class OrderItem extends StatefulWidget {
  ord.OrderItem orderItem;

  OrderItem(this.orderItem, {Key? key}) : super(key: key);
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.orderItem.price}"),
            subtitle: Text(widget.orderItem.dataTime),
            trailing: IconButton(
              icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                  print("expanded: $expanded");
                });
              },
            ),
          ),
          if (expanded)
            SizedBox(
                height: 150,
                child: ListView(
                  shrinkWrap: true,
                  children: widget.orderItem.products
                      .map((e) => ListTile(
                            title: Text(e.title),
                            subtitle: Text("${e.quantity}x${e.price} "),
                            trailing: Text("${e.quantity * e.price}"),
                          ))
                      .toList(),
                ))
        ],
      ),
    );
  }
}
