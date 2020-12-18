import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'dart:io';
import 'dart:math';

import 'dart:async';
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:flutter_login_signup/src/Pages/Settings/editProfile.dart';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Widgets/socialMedia.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'package:flutter_login_signup/src/Pages/News/newsListPage.dart';

class NotificationPage extends StatefulWidget {
  Map notification;

  NotificationPage({this.notification});

  @override
  _NotificationPageState createState() => _NotificationPageState(notification);
}

class _NotificationPageState extends State<NotificationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Map notification;

  final ScrollController scrollController = ScrollController();

  _NotificationPageState(this.notification) {
    print(this.notification);
    print(this.notification['data']);
    print(this.notification['data']['patient_name']);
    print(this.notification['data']['blood_type']);
    print(this.notification['data']['hosptial_name']);
    print(this.notification['data']['contact_name']);
    print(this.notification['data']['contact_number']);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: Text('notification'),
        ),
        bottomNavigationBar: new Container(
            height: 20.0,
            color: Color(0xFF573555),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[

              SizedBox(height: 50,),
            Image.asset(
              'assets/notification/notification.png',
              height: 100,
              width: 100,
            ),
              SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Notification Type',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Patient Name     ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Blood Type           ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hosptial Name   ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Contact Name     ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Blood Request',
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification['data']['patient_name'],
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification['data']['blood_type'],
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification['data']['hospital_name'],
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification['data']['contact_number'],
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
