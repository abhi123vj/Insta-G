import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/Feed/FeedHelper.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      drawer: Drawer(),
      appBar: Provider.of<Feedhelper>(context,listen: false).appBar(context),
      body: Provider.of<Feedhelper>(context,listen: false).feedBody(context),
    );
  }
}