import 'package:flutter/material.dart';
import 'package:trustme/src/screen/widgets/sizeconfig.dart';

class HeadingWidget extends StatelessWidget {
  final String text1;

  HeadingWidget({this.text1});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              child: Text(
                text1,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadingWidget2 extends StatelessWidget {
  final String text2;

  HeadingWidget2({this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal,
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              child: Text(
                text2,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadingWidget3 extends StatelessWidget {
  final String text3;

  HeadingWidget3({this.text3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            child: Text(
              text3,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
