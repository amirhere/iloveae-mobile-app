import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';

import 'package:load/load.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_signup/src/Pages/BloodRequest/bloodRequestNotification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class BloodRequestNotificationPage extends StatefulWidget {
  BloodRequestNotificationPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BloodRequestNotificationPageState createState() =>
      _BloodRequestNotificationPageState();
}

class _BloodRequestNotificationPageState
    extends State<BloodRequestNotificationPage> {
  String title = "halo";
  String helper;

  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Center(
         child:  Text('Blood Request Details'),
      ),),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: height,
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text(title)),

          //    getGridView(height * 0.88, width),
        ],
      ),
    );
  }
}
