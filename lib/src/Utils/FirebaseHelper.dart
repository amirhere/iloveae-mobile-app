import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:load/load.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:device_info/device_info.dart';
import 'dart:io' show Platform;


 class  FirebaseHelper{

    FlutterLocalNotificationsPlugin flutterNotification = new FlutterLocalNotificationsPlugin();
    var androidInitialize;
    var iOSinitialize;
    var initializationSettings;



    static String device_token;



    static String fetchDeviceType() {
        if (Platform.isAndroid) {
            return  "android";
        }else if(Platform.isIOS){
            return   "ios";
        }else{
            return   "other";
        }
    }



    static Future<String> fetchDeviceTokenFromFB () async{
        FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        _firebaseMessaging.getToken().then((token){
            print("****** Device ID *******");
            print(token);
            return token;
        });
    }



    static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {

        print('wikiiisisisisi');
        print('this message never opens');


        if (message.containsKey('data')) {
            // Handle data message
            final dynamic data = message['data'];
        }

        if (message.containsKey('notification')) {
            // Handle notification message
            final dynamic notification = message['notification'];
        }


        // Or do other work.
    }



    showNotification() async{

        print(
            'hello world'
        );

      //  myBackgroundMessageHandler(message);

        var android = new AndroidNotificationDetails('channel ID', 'channel name', 'channel description');
        var ios = new IOSNotificationDetails();

        var platform = new NotificationDetails( android: android, iOS: ios);

        await flutterNotification.show(0, 'siisi', 'sififif', platform);
    }








}


