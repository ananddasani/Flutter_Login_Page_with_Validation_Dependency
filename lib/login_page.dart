import 'package:flutter/material.dart';

class LoggedIn extends StatelessWidget {
  const LoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logged In :)"),
      ),
      body: Center(
        child: Text(
          "You Logged In Succesfully",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
