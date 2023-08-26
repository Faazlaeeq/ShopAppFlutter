import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset("assets/images/white-logo.png", height: 60)),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              fillColor: Color.fromARGB(255, 180, 69, 69),
              labelText: "Username",
              hintText: "Enter your username",
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Password",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: const Text(
                    "Login",
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
