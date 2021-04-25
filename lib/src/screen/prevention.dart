import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trustme/src/screen/widgets/header.dart';
import 'package:trustme/src/screen/widgets/preventionCard.dart';

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: Color(0xFF0000000),
  fontWeight: FontWeight.bold,
);

class PreventionScreen extends StatefulWidget {
  @override
  _PreventionScreenState createState() => _PreventionScreenState();
}

class _PreventionScreenState extends State<PreventionScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              textTop: "Prevention",
              textBottom: "Do thrsr thing to prevent Covid-19.",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 25),
                                PreventionCard(
                                  title: 'Wash hands',
                                  subtitle:
                                      'Wash your hands\nregularly for 20\nsecond, with soap\nand wateror\nalcohoi-based\nhand rub',
                                  isActive: true,
                                  image: 'assets/icons/handwashing.svg',
                                ),
                                SizedBox(width: 50),
                                PreventionCard(
                                  title: 'Use mask',
                                  subtitle:
                                      'Always cover your\nmouyh and nose\nwith mask\nwhenever going\noutside.',
                                  isActive: true,
                                  image: 'assets/icons/mask.svg',
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 25),
                                PreventionCard(
                                  title: 'Avoid contact',
                                  subtitle:
                                      'Avoid close contact\n(1 meter or 3 feet\nwith people who are\nunwell.',
                                  isActive: true,
                                  image: 'assets/icons/virustransmission.svg',
                                ),
                                SizedBox(width: 50),
                                PreventionCard(
                                  title: 'Cover cough',
                                  subtitle:
                                      'Cover your nose\nand mouth with a\ndisposable tissue or\nflexed elbolw when\nyou cough or\nsneeze',
                                  isActive: true,
                                  image: 'assets/icons/sneeze.svg',
                                ),
                                SizedBox(height: 50),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
