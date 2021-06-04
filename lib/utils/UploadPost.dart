import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:g_chat/services/FirebaseOperations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UplaodPost with ChangeNotifier {
  TextEditingController captioncontroller = TextEditingController();
  final ConstantColors constantColors = ConstantColors();
  late File uploadPostImage;
  File get getUploadPostImage => uploadPostImage;
  late String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  late UploadTask imagePostUploadTask;

  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final pickedUserPostImage = await picker.getImage(source: source);
    pickedUserPostImage == null
        ? print("Select post")
        : uploadPostImage = File(pickedUserPostImage.path);
    print(uploadPostImage.path);

    showPostImage(context);
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColors.blueColor,
                      onPressed: () {
                        pickUploadPostImage(context, ImageSource.gallery);
                      },
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    MaterialButton(
                      color: constantColors.blueColor,
                      onPressed: () {
                        pickUploadPostImage(context, ImageSource.camera);
                      },
                      child: Text(
                        "Camera",
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReferance = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    imagePostUploadTask = imageReferance.putFile(uploadPostImage);
    await imagePostUploadTask.whenComplete(() {
      print("Post Updated");
      print('posts/${uploadPostImage.path}/${TimeOfDay.now()}');
    });
    imageReferance.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Divider(),
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: MediaQuery.of(context).size.height * .4,
                  //width: MediaQuery.of(context).size.width*.8,
                  child: Image.file(
                    uploadPostImage,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          try {
                            selectPostImageType(context);
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
                          uploadPostImageToFirebase().whenComplete(() {
                            editPostSheet(context);
                            print("Image Uploaded");
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
                ),
              ],
            ),
          );
        });
  }

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Divider(),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.image_aspect_ratio),
                              color: constantColors.greenColor,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.fit_screen),
                              color: constantColors.yellowColor,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 200,
                        width: 300,
                        child: Image.file(
                          uploadPostImage,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset('assets/icons/sunflower.png'),
                      ),
                      Container(
                        height: 110,
                        width: 5,
                        color: constantColors.blueColor,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        height: 120,
                        width: 330,
                        child: TextField(
                          maxLines: 5,
                          textCapitalization: TextCapitalization.words,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          maxLength: 100,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          controller: captioncontroller,
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              hintText: 'Add A Caption',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: constantColors.whiteColor)),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .uploadPostData(captioncontroller.text, {
                      'postimage': getUploadPostImageUrl,
                      'caption': captioncontroller.text,
                      'username': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserName,
                      'userimage': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserAvatar,
                      'useruid':
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      'time': Timestamp.now(),
                      'useremail': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .initUserEmail
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  color: constantColors.blueColor,
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * .75,
            width: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12)),
          );
        });
  }
}
