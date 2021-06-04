import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/Chatroom/Chatroom.dart';
import 'package:g_chat/screens/Feed/Feed.dart';
import 'package:g_chat/screens/HomePage/Homepage_Helper.dart';
import 'package:g_chat/screens/Profile/Profile.dart';
import 'package:g_chat/services/FirebaseOperations.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  // const Homepage({ Key? key }) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState(); 
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() { 
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
    
  }

  ConstantColors constantColors = ConstantColors();
  int pageIndex=0;
  final PageController homepageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homepageController,
        children: [Feed(), Chatroom(), Profile()],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (page){
          setState(() {
            pageIndex=page;
          });
        }
      ),
      bottomNavigationBar: Provider.of<HomepageHelper>(context,listen: false).bottomNavBar(context,pageIndex, homepageController) ,
    );
  }
}
