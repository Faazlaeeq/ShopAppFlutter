import 'package:flutter/material.dart';

class MySnackBars {
  static ScaffoldFeatureController successSnackBar(BuildContext context,
      {String? text}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text == null ? "Success" : "Success: $text",
          style: const TextStyle(color: Color.fromARGB(255, 6, 87, 9)),
        ),
        backgroundColor: const Color.fromARGB(255, 142, 255, 138),
      ),
    );
  }

  static ScaffoldFeatureController errorSnackBar(
      BuildContext context, String error) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: const TextStyle(color: Color.fromARGB(255, 87, 6, 6)),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 138, 138),
      ),
    );
  }
}
