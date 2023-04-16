import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

class CartItem extends StatelessWidget {
  String id;
  String productId;
  String title;
  double price;
  int quantity;

  CartItem(this.id, this.productId, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(

      direction: DismissDirection.endToStart,
      key: ValueKey(productId),
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      background: Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.redAccent,),
        child: Icon(Icons.delete_forever_outlined,size: 40,color: Colors.white,),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),

      ),

      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: FittedBox(
                    child: Text(
                      "\$$price",
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Total: \$${(price * quantity)}"),
              trailing: Text("$quantity x"),
            ),
          )),
    );
  }
}
