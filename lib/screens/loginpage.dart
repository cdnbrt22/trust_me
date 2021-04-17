import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum Formtype { login, register }

class _LoginPageState extends State<LoginPage> {
  final formkey = new GlobalKey<FormState>();

  String _email;
  String _password;
  Formtype _formtype = Formtype.login;

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
      // print('Form is vaild. Email: $_email, password: $_password');
    }
    return false;
    // print('Form is invaild. Email: $_email, password: $_password');
    //}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formtype == Formtype.login) {
          UserCredential result = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password);
          User user = result.user;
          print('Sign in: ${user.uid}');
        } else {
          UserCredential result = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password);
          User user = result.user;
          print('Register user: ${user.uid}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formkey.currentState.reset();
    setState(() {
      _formtype = Formtype.register;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      _formtype = Formtype.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInput() + buildSubmitButtons(),
                )),
          ),
        ));
  }

  List<Widget> buildInput() {
    return [
      new TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formtype == Formtype.login) {
      return [
        new RaisedButton(
          child: new Text('Sign in'),
          onPressed: validateAndSave,
        ),
        new FlatButton(
            onPressed: moveToRegister, child: Text('Create my account'))
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text('Create an account'),
          onPressed: validateAndSave,
        ),
        new FlatButton(
          child: new Text('Hava an account ? Login'),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
