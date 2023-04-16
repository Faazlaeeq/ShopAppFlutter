import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/routes.dart';

import '../provider/products.dart';

class ProductsList extends StatelessWidget {
  String id;
  String title;
  double price;
  String imgUrl;

  ProductsList(this.id, this.title, this.price, this.imgUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      subtitle: Text("\$$price"),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () => Navigator.pushNamed(
                    context, Routes.addProducts,
                    arguments: id),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text("Delete Product"),
                            content: Text("Do you want to delete $title?"),
                            actions: [
                              TextButton(
                                  onPressed: (() {
                                    Provider.of<Products>(context,
                                            listen: false)
                                        .deleteProduct(id);
                                    Navigator.of(context).pop(true);
                                  }),
                                  child: const Text("Yes")),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.of(context).pop(false);
                                  }),
                                  child: const Text("No")),
                            ],
                          ));
                },
                icon: const Icon(Icons.delete, color: Colors.redAccent))
          ],
        ),
      ),
    );
  }
}
