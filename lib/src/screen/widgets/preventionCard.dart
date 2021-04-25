import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PreventionCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isActive;

  const PreventionCard({
    Key key,
    this.image,
    this.title,
    this.subtitle,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  color: Color(0xff0000000),
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: Color(0xFF000000),
                ),
        ],
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 10),
          SvgPicture.asset('${image}', height: 90)
        ],
      ),
    );
  }
}
