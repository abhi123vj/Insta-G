import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/landingPage/landing_Helpers.dart';
import 'package:provider/provider.dart';

class Landingpage extends StatelessWidget {
  //const Landingpage({ Key? key }) : super(key: key);
  final ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(children: [bodyColor(),
      Provider.of<LandingHelpers>(context,listen: false).bodyImage(context),
      Provider.of<LandingHelpers>(context,listen: false).taglineText(context),
      Provider.of<LandingHelpers>(context,listen: false).mainButtons(context),
       Provider.of<LandingHelpers>(context,listen: false).privacyText(context)

      ],),
    );
  }
  bodyColor(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,stops: [0.5,0.9],colors: [
          constantColors.darkColor,
          constantColors.blueGreyColor
        ])
      ),
    );
  }
  
}