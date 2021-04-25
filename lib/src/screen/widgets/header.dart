import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trustme/src/screen/menu_dashboard.dart';
//import 'package:trustme/src/screen/assets/screens/menu_dashboard.dart';

const sHeadingTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w600,
);
const sHeadingTextStyle2 = TextStyle(
  fontSize: 15,
  //fontWeight: FontWeight.w600,
);

class MyHeader extends StatefulWidget {
  final String textTop;
  final String textBottom;

  const MyHeader({
    Key key,
    this.textTop,
    this.textBottom,
  }) : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(top: 50, right: 20),
        height: 280,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF21C05E),
              Color(0xFF60B5CF),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MenuDashboardsAndHome();
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 30,
                    left: 30,
                    child: Text(
                      "${widget.textTop}",
                      style: sHeadingTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 30,
                    child: Text(
                      "${widget.textBottom}",
                      style: sHeadingTextStyle2.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 280,
                    child: SvgPicture.asset(
                      'assets/icons/bacteria.svg',
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  ) // I dont know why it can't work without container
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
