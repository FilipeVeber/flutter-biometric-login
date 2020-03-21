import 'package:flutter/material.dart';

import 'BiometricAuthentication.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: RaisedButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            bool authenticated =
                await BiometricAuthentication().authenticateUser();
            if (authenticated) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            }
          },
        ),
      ),
    );
  }
}
