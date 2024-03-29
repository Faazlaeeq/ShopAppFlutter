import 'package:flutter/material.dart';

class BadgeWid extends StatelessWidget {
  final Widget? child;
  final String? value;
  final Color? color;

  const BadgeWid({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child ??
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color ?? Theme.of(context).primaryColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value ?? "0",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
