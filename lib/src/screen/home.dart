import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trustme/src/screen/login.dart';

// class HomeScreen extends StatelessWidget {
//   final _auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           FlatButton(
//             child: Text('Logout'),
//             onPressed: () {
//               _auth.signOut();
//               Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => LoginScreen()));
//             },
//           ),
//         ],
//       ),
//       body: Center(),
//     );
//   }
// }
//
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: new AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 60),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.menu,
                          size: 30.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Trust Me',
                        style: TextStyle(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.login_outlined),
                        tooltip: 'Increase volume by 10',
                        onPressed: () {
                          _auth.signOut();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
