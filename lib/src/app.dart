import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustme/src/screen/firestore/page/news_page.dart';
import 'package:trustme/src/screen/firestore/provider/todos.dart';

import 'package:trustme/src/screen/login.dart';
import 'package:trustme/src/screen/menu_dashboard.dart';
import 'package:trustme/src/screen/prevention.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sign in',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF186E77),
              brightness: Brightness.light,
              primaryColor: Colors.white,
            ),
            home: LoginScreen()),
      );
}
