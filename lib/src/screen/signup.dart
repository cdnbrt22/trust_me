import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:trustme/src/screen/login.dart';
import 'package:trustme/src/screen/menu_dashboard.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;
  String _name;

  final _aunt = FirebaseAuth.instance;

  Widget _BuildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 55,
                          fontFamily: 'Roboto2'),
                    )
                  ],
                ),
                _buildEmailRow(),
                _buildPasswordRow(),
                _button(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Form(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'E-mail',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blueAccent,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _email = value.trim();
              });
            },
          ),
        ));
  }

  Widget _buildPasswordRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Form(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(
                Icons.lock_open_outlined,
                color: Colors.blueAccent,
              ),
            ),
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value.trim();
              });
            },
          ),
        ));
  }

  Widget _button() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
          child: new RaisedButton(
            child: SizedBox(child: new Text('Submit')),
            color: Colors.green,
            onPressed: () {
              _aunt.createUserWithEmailAndPassword(
                  email: _email, password: _password);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MenuDashboardsAndHome()));
            },
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF186E77),
      body: Stack(
        children: [
          BackButton(onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _BuildContainer(),
            ],
          ),
        ],
      ),
    );
  }
}
