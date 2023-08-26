import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isVisible = false;
  bool _isLogin = true;
  late Widget switchwidget;

  @override
  void initState() {
    switchwidget = switchwidgetfun();
    super.initState();
  }

  Widget switchwidgetfun() {
    Widget signupwidget = Column(
      key: const ValueKey<bool>(false),
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
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
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
                  "Sign Up",
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
    Widget loginwidget = Column(
      key: const ValueKey<bool>(true),
      children: [
        const TextField(
          decoration: InputDecoration(
            fillColor: Color.fromARGB(255, 180, 69, 69),
            labelText: "Email",
            hintText: "Enter your Email address",
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
      ],
    );

    return (_isLogin ? loginwidget : signupwidget);
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
          const SizedBox(height: 20),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 500), child: switchwidget),
          InkWell(
            onTap: () {
              setState(() {
                _isLogin = !_isLogin;

                switchwidget = switchwidgetfun();
              });
            },
            child: Text(
              _isLogin
                  ? "Don't have an account? Signup"
                  : "Already have and account? Login.",
              style: const TextStyle(
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
