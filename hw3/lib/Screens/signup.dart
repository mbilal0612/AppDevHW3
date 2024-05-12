import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _show = false;
  // var passwordController;
  // var EmailController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 200,
            width: 150,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0, left: 10.0, right: 10.0),
            child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                )),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(bottom: 90.0, left: 10.0, right: 10.0),
              child: TextField(
                  obscureText: _show,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.lock),
                        onPressed: () {
                          _show = !_show;
                          print(_show);
                        },
                      )))),
          const Text("New user?"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14),
            ),
            onPressed: () {},
            child: const Text("New user? Create Account"),
          )
        ],
      ),
    ))));
  }
}
