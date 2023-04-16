import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';

class DrawerWid extends StatelessWidget {
  const DrawerWid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello, There"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () => Navigator.pushReplacementNamed(context, "/"),
          ),
          ListTile(
              title: Text("Orders"),
              leading: Icon(Icons.shopping_bag),
              onTap: () => Navigator.pushNamed(context, Routes.orders)),
          ListTile(
              title: Text("Manage Products"),
              leading: Icon(Icons.color_lens),
              onTap: () => Navigator.pushNamed(context, Routes.userProducts)),
        ],
      ),
    );
  }
}
