import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trustme/src/api/CovidToday.dart';
import 'package:trustme/src/screen/firestore/page/news_page.dart';
import 'package:trustme/src/screen/widgets/counter.dart';

import 'package:http/http.dart' as http;
import 'package:trustme/src/screen/widgets/heading_widget.dart';
import 'package:trustme/src/screen/login.dart';
import 'package:trustme/src/screen/prevention.dart';

final Color backgroundColor = Color(0xFFFFFFFF);

class MenuDashboardsAndHome extends StatefulWidget {
  @override
  _MenuDashboardsAndHomeState createState() => _MenuDashboardsAndHomeState();
}

class _MenuDashboardsAndHomeState extends State<MenuDashboardsAndHome>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final _auth = FirebaseAuth.instance;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  CovidToday _dataFormAPI;
  String login;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    getResult();
    findDisplayName();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getResult() async {
    var responce_th =
        await http.get(Uri.https('covid19.th-stat.com', 'api/open/today'));

    setState(() {
      _dataFormAPI = covidTodayFromJson(responce_th.body);
    });
  }

  Future<Void> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          login = event.displayName;
        });
        print('#### login = $login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  //Menuscreen
  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        color: Colors.grey,
        child: ScaleTransition(
          scale: _menuScaleAnimation,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // FlatButton(
                  //   child: Text("Dashboard",
                  //       style: TextStyle(color: Colors.black, fontSize: 22)),
                  //   onPressed: () {},
                  // ),
                  FlatButton(
                    child: Text('Protect',
                        style: TextStyle(color: Colors.black, fontSize: 22)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => PreventionScreen()));
                    },
                  ),
                  FlatButton(
                    child: Text("News",
                        style: TextStyle(color: Colors.black, fontSize: 22)),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (contet) => HomePage()));
                    },
                  ),
                  SizedBox(height: 100),
                  Row(
                    children: [
                      FlatButton(
                        child: Text("Logout",
                            style:
                                TextStyle(color: Colors.black, fontSize: 22)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //onclick
  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          child: Material(
            animationDuration: duration,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            elevation: 0,
            color: backgroundColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(
                          child: Icon(Icons.menu, color: Colors.grey),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                        Text("Trust Me",
                            style: TextStyle(fontSize: 24, color: Colors.grey)),
                      ],
                    ),
                    //dashboard

                    Container(
                        child: Container(
                            height: 300,
                            width: double.infinity,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              top: 40),
                                          height: 180,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF21C05E),
                                              Color(0xFF60B5CF),
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                          ),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(text: 'Welcome to'),
                                            TextSpan(
                                                text:
                                                    '\n       \nTrust me Application')
                                          ])),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 15),
                                          child: SvgPicture.asset(
                                              'assets/icons/nurse.svg'),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/virus.svg',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                14),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              HeadingWidget(text1: 'Thailand'),
                                              HeadingWidget3(
                                                  text3:
                                                      'Last update: ${_dataFormAPI?.updateDate ?? '...'}'),
                                            ]),
                                        SvgPicture.asset(
                                            'assets/icons/virus.svg',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                14),
                                      ],
                                    ),
                                  )
                                ]))),
                    // SizedBox(height: 10),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              .318,
                                      vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 10,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Counter(
                                        color: Colors.orange,
                                        showApi:
                                            '${_dataFormAPI?.confirmed ?? '...'}',
                                        title: 'Confirmed',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 5,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Counter(
                                          color: Colors.green,
                                          showApi:
                                              '${_dataFormAPI?.recovered ?? '...'}',
                                          title: 'Recovered',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 5,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Counter(
                                        color: Colors.blueAccent,
                                        showApi:
                                            '${_dataFormAPI?.hospitalized ?? '...'}',
                                        title: 'Hospitalized',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 5,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Counter(
                                          color: Colors.red,
                                          showApi:
                                              '${_dataFormAPI?.deaths ?? '...'}',
                                          title: 'Died',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
