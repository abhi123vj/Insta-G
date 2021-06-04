import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/constants/Constantcolors.dart';
import 'package:g_chat/screens/Feed/FeedHelper.dart';
import 'package:g_chat/screens/HomePage/Homepage_Helper.dart';
import 'package:g_chat/screens/Profile/ProfileHelper.dart';
import 'package:g_chat/screens/landingPage/landingUtils.dart';
import 'package:g_chat/screens/landingPage/landing_Helpers.dart';
import 'package:g_chat/screens/landingPage/landing_Services.dart';
import 'package:g_chat/screens/splashscreen/splashs_Screen.dart';
import 'package:g_chat/services/Authentication.dart';
import 'package:g_chat/services/FirebaseOperations.dart';
import 'package:g_chat/utils/UploadPost.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
        theme: ThemeData(
            dividerTheme: DividerThemeData(
              space: 20,
              thickness: 4,
              color: constantColors.whiteColor,
              indent: 150,
              endIndent: 150,
            ),
            accentColor: constantColors.blueColor,
            fontFamily: "Popins",
            canvasColor: Colors.transparent),
      ),
      providers: [
        ChangeNotifierProvider(
          create: (_) => Feedhelper(),
        ),
        ChangeNotifierProvider(
          create: (_) => UplaodPost(),
        ),
        ChangeNotifierProvider(
          create: (_) => LandingHelpers(),
        ),
        ChangeNotifierProvider(
          create: (_) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (_) => Landingservices(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseOperations(),
        ),
         ChangeNotifierProvider(
          create: (_) => LandingUtils(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomepageHelper(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileHelper(),
        )
      ],
    );
  }
}
