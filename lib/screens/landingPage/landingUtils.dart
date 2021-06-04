import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/landingPage/landing_Services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();

  final picker = ImagePicker();
  late File userAvatar;
  File get getUserAvatar => userAvatar;
  String? userAvatarUrl;
  String? get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.getImage(source: source);
    pickedUserAvatar == null
        ? print("Select image")
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    try {

      Provider.of<Landingservices>(context, listen: false)
          .showUserAvatar(context);
    } catch (e) {
      print("error kitti landing page");
            

    }

    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColors.blueColor,
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        pickUserAvatar(context, ImageSource.gallery)
                            .whenComplete(() {
                          Navigator.pop(context);
                          Provider.of<Landingservices>(context, listen: false)
                              .showUserAvatar(context);
                        });
                      },
                    ),
                    MaterialButton(
                      color: constantColors.blueColor,
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      onPressed: () {
                        pickUserAvatar(context, ImageSource.camera)
                            .whenComplete(() {
                          Navigator.pop(context);
                          Provider.of<Landingservices>(context, listen: false)
                              .showUserAvatar(context);
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
