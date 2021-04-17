import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trustme/src/screen/home.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;

  Widget _BuildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
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
        )
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ),
        new FlatButton(
            onPressed: () {
              _auth.createUserWithEmailAndPassword(
                  email: _email, password: _password);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Text('Create my account'))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   title: Text('Login'),
            // ),

            body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.25,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red[800],
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(100),
                    bottomRight: const Radius.circular(100))),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _BuildLogo(),
                _BuildContainer(),
                /*Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email', hintText: 'none@none.com'),
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                    ),
                  ),
                  new RaisedButton(
                    child: new Text('Sign in'),
                    onPressed: () {
                      _auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        _auth.createUserWithEmailAndPassword(
                            email: _email, password: _password);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                      child: Text('Create my account'))*/
              ],
            ),
          ),
        ),
        //),
      ],
    )));
  }
}
