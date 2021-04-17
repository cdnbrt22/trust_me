import 'package:flutter/material.dart';
import 'package:trustme/src/screen/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.brown[500],
        accentColor: Colors.blue[200],
        fontFamily: 'Font1',
      ),
      home: LoginScreen(),
    );
  }
}
