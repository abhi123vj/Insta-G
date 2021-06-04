import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/screens/landingPage/landingUtils.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask? imageUploadTask;
  String? initUserEmail, initUserName;
  String? initUserAvatar;
  String? get getinitUserEmail => initUserEmail;
  String? get getinitUserName => initUserName;
  String? get getinitUserAvatar => initUserAvatar;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imagerReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
    imageUploadTask = imagerReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask!.whenComplete(() {
      print("Image Uploaded");
    });
    imagerReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          "the user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}");
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    print(data);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print("Fetchinf User Data");
      initUserName = doc.data()?['username'];
      initUserEmail = doc.data()?['useremail'];
      initUserAvatar = doc.data()?['userimage'];
      print(initUserName);
      print(initUserEmail);
      print(initUserAvatar);

      notifyListeners();
    });
  }

  Future uploadPostData(String PostId,dynamic data) async{
    return FirebaseFirestore.instance.collection('posts').doc(PostId).set(data);
  }
}
