import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:flutter_login_signup/src/Pages/Notification/notificationPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:toast/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_signup/src/Utils/FirebaseHelper.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String title = "";
  String helper;




  /* Overridden Methods */
  @override
  void initState() {
    super.initState();

    print('inside init method now...');
    fetchDeviceTokenFromFB().then((value){
        getNavigationCueFromSharedPreferenceBasedonCheckBox();
    });


    _firebaseMessaging.configure( onLaunch: (message) async {

        title = message['data']['blood_type'];
        helper = "You have opened  the app from notification";

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));

    });


      // for splash screen

  }





  /* Widgets  */
  Widget _title() {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Image.asset('assets/logo.png'),
    ));
  }








  Future fetchDeviceTokenFromFB() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if(!(preferences.containsKey('device_id'))){

          print('registering device to firebase...');
          _firebaseMessaging.getToken().then((token) {
              print('device is registered successfully');
              print("****** Device ID *******");
              print("Token is  " + token);
              preferences.setString('device_id', token);
              Toast.show(token.toString(),
                  context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.BOTTOM);


          });
      }
  }




  /* Logic For Navigation based on Checkbox  */
  void getNavigationCueFromSharedPreferenceBasedonCheckBox() async {
      print('running  navigation cue method...');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("isUserLoggedIn")) {
      if (prefs.getBool("isUserLoggedIn")) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Timer(Duration(seconds: 8), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        });
      }
    } else {
      Timer(Duration(seconds: 8), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }





  @override
  Widget build(BuildContext context) {
      print('in the build context');
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  _title()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
