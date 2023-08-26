import 'package:flutter/material.dart';

import '../routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isVisible;
  @override
  void initState() {
    isVisible = false;

    super.initState();
  }

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
          const SizedBox(height: 40),
          Visibility(
              visible: false,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 180, 69, 69),
                      labelText: "Full Name",
                      hintText: "Enter your Name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Color.fromARGB(255, 180, 69, 69),
                      labelText: "Email",
                      hintText: "Enter your Email address",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Password",
                      suffixIcon: IconButton(
                        iconSize: 15,
                        visualDensity: VisualDensity.compact,
                        splashRadius: 20,
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                      ),
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
              )),
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
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.signup);
            },
            child: const Text(
              "Don't have an account? Signup",
              style: TextStyle(
                height: 2,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
