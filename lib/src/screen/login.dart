import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:trustme/src/screen/assets/screens/menu_dashboard.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:trustme/src/screen/menu_dashboard.dart';
import 'package:trustme/src/screen/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();

  Widget _BuildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/icons/virus.svg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 8,
        ),
        SizedBox(height: 10),
        Text(
          'Trust Me',
          style: TextStyle(
            fontFamily: "font1",
            fontSize: MediaQuery.of(context).size.height / 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ],
    );
  }

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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 2.0,
                ),
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
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 1.5,
                ),
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
            child: SizedBox(child: new Text('Sign in')),
            color: Colors.green,
            onPressed: () {
              _auth.signInWithEmailAndPassword(
                  email: _email, password: _password);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MenuDashboardsAndHome()));
            },
          ),
        ),
      ],
    ));
  }

  Widget _signupButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
              child: Row(children: [
            Text('Don\'t hava a account ?'),
            FlatButton(
                child: Text('Sign up',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                  // _auth.createUserWithEmailAndPassword(
                  //     email: _email, password: _password);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUp()));
                }),
          ])))
    ]);
  }

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFF186E77),
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _BuildLogo(),
                    _BuildContainer(),
                    _signupButton(),
                  ],
                ),

                //),
              ],
            )));
  }
}
