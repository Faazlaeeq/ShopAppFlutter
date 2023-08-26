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
            title: const Text("Home"),
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pushReplacementNamed(context, "/"),
          ),
          ListTile(
              title: const Text("Orders"),
              leading: const Icon(Icons.shopping_bag),
              onTap: () => Navigator.pushNamed(context, Routes.orders)),
          ListTile(
              title: const Text("Manage Products"),
              leading: const Icon(Icons.color_lens),
              onTap: () => Navigator.pushNamed(context, Routes.userProducts)),
        ],
      ),
    );
  }
}
