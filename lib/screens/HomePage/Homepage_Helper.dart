import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class HomepageHelper with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget bottomNavBar(BuildContext context,int index, PageController pageController) {
    return CustomNavigationBar(
      currentIndex: index,
      bubbleCurve: Curves.bounceIn,
      scaleCurve: Curves.decelerate,
      selectedColor: constantColors.blueColor,
      unSelectedColor: constantColors.whiteColor,
      strokeColor: constantColors.blueColor,
      scaleFactor: 0.5,
      iconSize: 30,
      onTap: (val) {
        index = val;
        pageController.jumpToPage(val);
        notifyListeners();
      },
      backgroundColor: Color(0xff040307),
      items: [
        CustomNavigationBarItem(icon: Icon(EvaIcons.home)),
        CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
        CustomNavigationBarItem(
            icon: CircleAvatar(
          radius: 35,
          backgroundColor: constantColors.blueGreyColor,
          backgroundImage:NetworkImage( Provider.of<FirebaseOperations>(context,listen: true).getinitUserAvatar ?? "https://www.mathrubhumi.com/polopoly_fs/1.3790328.1558501624!/image/image.jpg_gen/derivatives/landscape_894_577/image.jpg"),

        )),
      ],
    );
  }
}
