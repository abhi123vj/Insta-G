import 'dart:async';

import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/landingPage/landing_Page.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatefulWidget {
  // Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ConstantColors constantColors = ConstantColors();
  @override
  // ignore: must_call_super
  void initState() {
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: Landingpage(), type: PageTransitionType.leftToRight)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
            text: TextSpan(
                text: 'The',
                style: TextStyle(
                    fontFamily: 'Popins',
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                children: <TextSpan>[
              TextSpan(
                  text: "Social",
                  style: TextStyle(
                      fontFamily: 'Popins',
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 34))
            ])),
      ),
    );
  }
}
