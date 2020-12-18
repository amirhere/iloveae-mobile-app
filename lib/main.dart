import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:load/load.dart';

import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:flutter_login_signup/src/Pages/welcomePage.dart';
import 'package:flutter_login_signup/src/Pages/BusinessDirectory/jobSearchPage.dart';
import 'package:flutter_login_signup/src/Pages/Auth/forgotPasswordPage.dart';
import 'package:flutter_login_signup/src/Pages/Auth/registration.dart';
import 'package:flutter_login_signup/src/Pages/homePage.dart';
import 'package:flutter_login_signup/src/Pages/stackykeibler.dart';
import 'package:toast/toast.dart';

import 'package:flutter_login_signup/src/Pages/News/newsPage.dart';
import 'package:flutter_login_signup/src/Pages/Events/EventsList.dart';
import 'package:flutter_login_signup/src/Pages/News/newsListPage.dart';
import 'package:flutter_login_signup/src/Pages/SuccessStories/successStoriesListPage.dart';
import 'package:flutter_login_signup/src/Pages/Tourism/tourismSearchPage.dart';
import 'package:flutter_login_signup/src/Pages/Tourism/tourismArticleListPage.dart';
import 'package:flutter_login_signup/src/Pages/BloodRequest/bloodRequest.dart';
import 'package:flutter_login_signup/src/Pages/BloodRequest/bloodRequestNotification.dart';
import 'package:flutter_login_signup/src/Pages/Notification/notificationPage.dart';
import 'package:flutter_login_signup/src/Pages/webview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:ui';
import 'package:flutter/services.dart';




void main(){



    runApp(
        LoadingProvider(
            themeData: LoadingThemeData(),
            loadingWidgetBuilder: (ctx, data) {
                return Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Container(
                            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))

                            // color: Colors.white,
                        ),
                    ),
                );
            },

            child: MyApp(),
        ),

    );




}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         // primaryColor: Color(0xFF573555),
          primaryColor: Color(0xFF573555),
          accentColor: Color(0xff84849d),
          backgroundColor: Color(0xffc7dceb),




         toggleableActiveColor: Color(0xFF6A596D),
         primarySwatch: Colors.lightBlue,

         visualDensity: VisualDensity.adaptivePlatformDensity,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
