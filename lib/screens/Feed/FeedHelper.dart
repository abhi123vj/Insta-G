import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:g_chat/utils/UploadPost.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Feedhelper with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.camera_enhance_rounded),
          color: constantColors.greenColor,
          onPressed: () {
            Provider.of<UplaodPost>(context, listen: false)
                .selectPostImageType(context);
          },
        )
      ],
      title: RichText(
        text: TextSpan(
            text: 'Social',
            style: TextStyle(
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                  text: 'Feed',
                  style: TextStyle(
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20))
            ]),
      ),
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: 500,
                  width: 400,
                  child: Lottie.asset('assets/animations/loading.json'),
                ),
              );
            } else {
              return loadPoasts(context, snapshot);
            }
          },
        ),
        height: MediaQuery.of(context).size.height * .9,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      ),
    );
  }

  Widget loadPoasts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
        return Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 8, right: 8, left: 8),
          decoration: BoxDecoration(
              color: constantColors.blueGreyColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(10)),
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: constantColors.transperant,
                      radius: 20,
                      backgroundImage:
                          NetworkImage(documentSnapshot.get('userimage')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.only(left: 8),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            documentSnapshot.get('caption'),
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                                text: documentSnapshot.get('username'),
                                style: TextStyle(
                                    color: constantColors.blueColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' , 12 hours ago',
                                      style: TextStyle(
                                          color: constantColors.lightColor
                                              .withOpacity(.8)))
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: .5,
                height: 10,
                color: constantColors.whiteColor.withOpacity(.4),
                indent: 0,
                endIndent: 0,
              ),
              Expanded(
                child: Container(
                  //color: constantColors.blueGreyColor.withOpacity(.8),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Material(
                      elevation: 5,
                      child: Image.network(
                        documentSnapshot.get("postimage"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: .5,
                height: 10,
                color: constantColors.whiteColor.withOpacity(.4),
                indent: 0,
                endIndent: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8),
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: constantColors.redColor,
                              size: 22,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Icon(
                              FontAwesomeIcons.comment,
                              color: constantColors.blueColor,
                              size: 22,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            child: Icon(
                              FontAwesomeIcons.award,
                              color: constantColors.yellowColor,
                              size: 22,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Provider.of<Authentication>(context, listen: false)
                              .getUserUid ==
                          documentSnapshot.get("useruid")
                      ? IconButton(
                          icon: Icon(EvaIcons.moreVertical,
                              color: constantColors.whiteColor),
                          onPressed: () {},
                        )
                      : Container(
                          width: 0,
                          height: 0,
                        )
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
