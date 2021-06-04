import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/HomePage/home_page.dart';
import 'package:g_chat/screens/landingPage/landingUtils.dart';
import 'package:g_chat/screens/landingPage/landing_Services.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/login.png"))),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
        top: 460,
        left: 10,
        child: Container(
          constraints: BoxConstraints(maxWidth: 170),
          child: RichText(
              text: TextSpan(
                  text: 'Are ',
                  style: TextStyle(
                      fontFamily: 'Popins',
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                  children: <TextSpan>[
                TextSpan(
                    text: "You ",
                    style: TextStyle(
                        fontFamily: 'Popins',
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34)),
                TextSpan(
                    text: "Social",
                    style: TextStyle(
                        fontFamily: 'Popins',
                        color: constantColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34)),
                TextSpan(
                    text: "?",
                    style: TextStyle(
                        fontFamily: 'Popins',
                        color: constantColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34))
              ])),
        ));
  }

  Widget mainButtons(BuildContext context) {
    return Positioned(
        top: 630,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Sign in with google");

                  emailAuthSheeet(context);
                },
                child: Container(
                  width: 80,
                  height: 40,
                  child: Icon(EvaIcons.emailOutline,
                      color: constantColors.yellowColor),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.yellowColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Sign in with google");
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: Homepage(),
                            type: PageTransitionType.leftToRight));
                  });
                },
                child: Container(
                  width: 80,
                  height: 40,
                  child: Icon(EvaIcons.google, color: constantColors.redColor),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.redColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              GestureDetector(
                child: Container(
                  width: 80,
                  height: 40,
                  child:
                      Icon(EvaIcons.facebook, color: constantColors.blueColor),
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.blueColor),
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ));
  }

  Widget privacyText(BuildContext context) {
    return Positioned(
        top: 720,
        left: 20,
        right: 20,
        child: Container(
          child: Column(
            children: [
              Text(
                "By continuing you agree theSocial's terms of",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              Text(
                "Services and Privacy Policy",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              )
            ],
          ),
        ));
  }

  emailAuthSheeet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Divider(),
                Provider.of<Landingservices>(context, listen: false)
                    .passwordlessSignIn(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColors.blueColor,
                      onPressed: () {
                        Provider.of<Landingservices>(context, listen: false)
                            .loginSheet(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MaterialButton(
                      color: constantColors.redColor,
                      onPressed: () {
                        Provider.of<LandingUtils>(context, listen: false)
                            .selectAvatarOptionsSheet(context);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
          );
        });
  }
}
