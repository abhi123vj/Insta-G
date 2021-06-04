import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/Profile/ProfileHelper.dart';
import 'package:g_chat/screens/landingPage/landing_Page.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  //const Profile({ Key? key }) : super(key: key);
  final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            EvaIcons.settings2Outline,
            color: constantColors.lightBlueColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Provider.of<ProfileHelper>(context,listen: false).logOutDialog(context);
            },
            icon: Icon(EvaIcons.logOutOutline),
            color: constantColors.greenColor,
          )
        ],
        title: RichText(
          text: TextSpan(
              text: 'My',
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                    text: 'Profile',
                    style: TextStyle(
                        color: constantColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))
              ]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<Authentication>(context, listen: false)
                      .getUserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Provider.of<ProfileHelper>(context, listen: false)
                          .headerProfile(context, snapshot),
                      Divider(
                        height: 0,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: constantColors.blueGreyColor,
                      ),
                      Provider.of<ProfileHelper>(context, listen: false)
                          .middleProfile(context, snapshot),
                          Provider.of<ProfileHelper>(context, listen: false)
                          .footerProfile(context, snapshot),
                    ],
                  );
                }
              },
            ),
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
