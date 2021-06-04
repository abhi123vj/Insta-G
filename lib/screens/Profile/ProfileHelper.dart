import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/landingPage/landing_Page.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileHelper with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();

  Widget headerProfile(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .25,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      try {
                        print("tsting thodagi");
                        print(snapshot.data);
                      } catch (e) {
                        print("Errror ANu");
                        print(e);
                        print("Errror theernnu");
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: constantColors.transperant,
                      radius: 60,
                      backgroundImage:
                          NetworkImage(snapshot.data?.get('userimage')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      snapshot.data?.get('username'),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          EvaIcons.email,
                          color: constantColors.greenColor,
                          size: 16,
                        ),
                        Text(
                          snapshot.data?.get('useremail'),
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        constraints:
                            BoxConstraints(minWidth: 70, minHeight: 80),
                        decoration: BoxDecoration(
                            color: constantColors.darkColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        constraints:
                            BoxConstraints(minWidth: 70, minHeight: 80),
                        decoration: BoxDecoration(
                            color: constantColors.darkColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        constraints:
                            BoxConstraints(minWidth: 70, minHeight: 80),
                        decoration: BoxDecoration(
                            color: constantColors.darkColor,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsetsDirectional.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.userAstronaut,
                color: constantColors.yellowColor,
                size: 16,
              ),
              Text("Recently Added",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: constantColors.whiteColor))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height * .1,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.darkColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(15)),
        )
      ],
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Container(
      child: Image.asset("assets/images/chatbox1.png"),
      margin: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * .55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: constantColors.darkColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  logOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: constantColors.darkColor,
            
            title: Text(
              'Log Out of theSocial?',
              style: TextStyle(
                color: constantColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              MaterialButton(
                
                onPressed: () {
                  Provider.of<Authentication>(context,listen: false).logooutviaEmail().whenComplete(() {
                Navigator.pushReplacement(context, PageTransition(child: Landingpage(),type:PageTransitionType.bottomToTop ));
              });
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              MaterialButton(
                color: constantColors.redColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: constantColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      ),
                ),
              )
            ],
          );
        });
  }
}
