import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isVisible = false;
  bool _isLogin = true;
  late Widget switchwidget;
  TextEditingController email_controller = TextEditingController();
  TextEditingController _s_email = TextEditingController();
  TextEditingController pass_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController _s_pass = TextEditingController();

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
        TextField(
          controller: _s_email,
          decoration: const InputDecoration(
            fillColor: Color.fromARGB(255, 180, 69, 69),
            labelText: "Email",
            hintText: "Enter your Email address",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          obscureText: !isVisible,
          controller: _s_pass,
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
                onPressed: signUp,
              ),
            ),
          ],
        )
      ],
    );
    Widget loginwidget = Column(
      key: const ValueKey<bool>(true),
      children: [
        TextField(
          controller: email_controller,
          decoration: const InputDecoration(
            fillColor: Color.fromARGB(255, 180, 69, 69),
            labelText: "Email",
            hintText: "Enter your Email address",
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: pass_controller,
          decoration: const InputDecoration(
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
                onPressed: login,
              ),
            ),
          ],
        ),
      ],
    );

    return (_isLogin ? loginwidget : signupwidget);
  }

  void signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _s_email.text, password: _s_pass.text)
          .then((value) => Navigator.pushNamed(
                context,
                Routes.productsOverview,
              ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
  }

  void login() async {
    try {
      print("cliked");

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email_controller.text, password: pass_controller.text)
          .then(
              (value) => Navigator.pushNamed(context, Routes.productsOverview));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
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
          Column(
            key: const ValueKey<bool>(false),
            children: [
              Visibility(
                visible: !_isLogin,
                maintainAnimation: true,
                maintainInteractivity: true,
                maintainSize: true,
                maintainState: true,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isLogin ? 0 : 45,
                  child: TextField(
                    controller: name_controller,
                    autofillHints: const [
                      AutofillHints.name,
                      AutofillHints.nickname
                    ],
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: email_controller,
                decoration: const InputDecoration(
                  fillColor: Color.fromARGB(255, 180, 69, 69),
                  labelText: "Email",
                  hintText: "Enter your Email address",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: !isVisible,
                controller: pass_controller,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  suffixIcon: IconButton(
                    iconSize: 15,
                    splashRadius: 20,
                    icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off),
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
                      onPressed: signUp,
                      child: const Text(
                        "Sign Up",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
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
