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
import 'package:webview_flutter/webview_flutter.dart';




import 'dart:async';

import 'package:flutter/material.dart';




class WebViewPage extends StatefulWidget {


  WebViewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String title = "";
  String helper;

  FlutterLocalNotificationsPlugin flutterNotification =
      new FlutterLocalNotificationsPlugin();
  var androidInitialize;
  var iOSinitialize;
  var initializationSettings;




  /* Overridden Methods */
  @override
  void initState() {
    super.initState();

    setLocalPushNotificationSettings();
    fetchDeviceTokenFromFB();


    _firebaseMessaging.configure(onMessage: (message) async {
      setState(() {
        title = message['data']['blood_type'];
        helper = "You have received a new notification";

        _showNotification();
      });
    }, onResume: (message) async {

        title = message['data']['patient_name'];
        helper = "You have opened  the app from notification";
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));

    }, onLaunch: (message) async {

        title = message['data']['blood_type'];
        helper = "You have opened  the app from notification";

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));



    });

    // for splash screen
   // getNavigationCueFromSharedPreferenceBasedonCheckBox();
  }



  /* Widgets  */
  Widget _title() {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Image.asset('assets/logo.png'),
    ));
  }



  setLocalPushNotificationSettings() {
    // for local push notification
    androidInitialize = new AndroidInitializationSettings('ic_launcher');
    iOSinitialize = new IOSInitializationSettings();

    initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSinitialize);
    flutterNotification.initialize(initializationSettings);
  }





  void fetchDeviceTokenFromFB() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if(!(preferences.containsKey('device_id'))){
          _firebaseMessaging.getToken().then((token) {
              print("****** Device ID *******");
              print("Token is  " + token);
              preferences.setString('device_id', token);
          });
      }
  }




  /* Logic For Navigation based on Checkbox  */
  void getNavigationCueFromSharedPreferenceBasedonCheckBox() async {
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



  _showNotification() async {
    var android = new AndroidNotificationDetails(
        'channel ID', 'channel name', 'channel description');
    var ios = new IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await flutterNotification.show(0, 'siisi', 'sififif', platform);
  }


  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;


    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: height * 0.03 ),
            child: WebView(
                initialUrl: "https://sailserver.com/",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController){
                    _controller.complete(webViewController);

                },

            ),
        ),
    );
  }
}
