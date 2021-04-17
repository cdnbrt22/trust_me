import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trustme/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.brown[500],
//         accentColor: Colors.blue[200],
//         fontFamily: 'Font1',
//       ),
//       home: LoginPage(),
//     );
//   }
// }
