import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/HomePage/home_page.dart';
import 'package:g_chat/screens/landingPage/landingUtils.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:g_chat/services/FirebaseOperations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Landingservices with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Divider(),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: constantColors.transperant,
                  backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .userAvatar),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          try {
                            Provider.of<LandingUtils>(context, listen: false)
                                .pickUserAvatar(context, ImageSource.gallery);
                          } catch (e) {
                            print("error kitti landing servc");
                          }
                        },
                        child: Text(
                          'Reselect',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: constantColors.whiteColor),
                        ),
                      ),
                      MaterialButton(
                        color: constantColors.blueColor,
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .uploadUserAvatar(context)
                              .whenComplete(() {
                            signInSheet(context);
                          });
                        },
                        child: Text(
                          'Confirm Image',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(color: constantColors.blueGreyColor),
          );
        });
  }

  Widget passwordlessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return new ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot documentSnapshot) {
                return ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.trashAlt,
                      color: constantColors.redColor,
                    ),
                    onPressed: () {},
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        (documentSnapshot.data() as dynamic)['userimage']),
                  ),
                  title: Text(
                    (documentSnapshot.data() as dynamic)["username"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.greenColor),
                  ),
                  subtitle: Text(
                    (documentSnapshot.data() as dynamic)['useremail'],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: constantColors.greenColor),
                  ),
                );
              }).toList());
            }
          }),
    );
  }

  loginSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: "Enter your Email...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: constantColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: "Enter your password...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: constantColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warnningText(context, "Fill All Datas");
                        }
                      },
                      backgroundColor: constantColors.blueColor,
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: constantColors.whiteColor,
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
          );
        });
  }

  signInSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantColors.blueGreyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(),
                  CircleAvatar(
                    backgroundImage: FileImage(
                        Provider.of<LandingUtils>(context, listen: false)
                            .getUserAvatar),
                    backgroundColor: constantColors.redColor,
                    radius: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: "Enter name...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: constantColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: constantColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: "Enter your password...",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: constantColors.whiteColor),
                      ),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: constantColors.whiteColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .createNewAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            print("Creating collection");
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .createUserCollection(context, {
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': userEmailController.text,
                              'username': userNameController.text,
                              'userimage': Provider.of<LandingUtils>(context,
                                      listen: false)
                                  .getUserAvatarUrl
                            });
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
                          warnningText(context, "Fill All Datas");
                        }
                      },
                      backgroundColor: constantColors.redColor,
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: constantColors.whiteColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  warnningText(BuildContext context, String warnig) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width,
            child: Text(
              warnig,
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
