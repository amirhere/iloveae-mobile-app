import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';

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
import 'package:flutter_login_signup/src/Widgets/socialMedia.dart';
import 'package:url_launcher/url_launcher.dart';


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
          centerTitle: true,
            title: Text('Blood Request'),
        ),

        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[


            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),

              child: Column(
                children: [


                  SizedBox(height: 60,),
                  Image.asset(
                    'assets/notification/blood_donations_header.png',
                    //  height: 100,

                  ),


                  SizedBox(height: 10,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        flex: 2,
                        child: Text(
                            "Patient Name:", style: TextStyle(
                          color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14
                        ),
                        ),
                      ),


                      Expanded(
                        flex: 3,
                        child:  Text(
                          notification['data']['patient_name'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColor, fontSize: 14
                          ),
                        ),
                      )
                    ],
                  ),


                  SizedBox(
                    height: 8,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        flex: 2,
                        child: Text(
                            "Blood Type:",style: TextStyle(
                        color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14
                  )
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child:  Text(
                          notification['data']['blood_type'],
                          style: TextStyle(
                              fontSize: 14, color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),


                  SizedBox(
                    height: 8,
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        flex: 2,
                        child: Text(
                            "Hospital Name:",style: TextStyle(
                            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14
                        )
                        ),
                      ),


                      Expanded(
                        flex: 3,
                        child:  Text(
                          notification['data']['hospital_name'],
                          style: TextStyle(
                              fontSize: 14, color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 8,
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        flex: 2,
                        child: Text(
                            "Contact Name:",style: TextStyle(
                            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14
                        )
                        ),
                      ),


                      Expanded(
                        flex: 3,
                        child:  Text(
                          notification['data']['contact_name'],
                          style: TextStyle(
                              fontSize: 14, color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  ),


                  SizedBox(
                    height: 8,
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [




                      Expanded(
                        flex: 2,
                        child: Text(
                            "Contact Number:",style: TextStyle(
                            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14
                        )
                        ),
                      ),



                      Expanded(
                        flex: 3,
                        child:  GestureDetector(
                          onTap: ()=>  launch("tel://"+notification['data']['contact_number']) ,
                          child: Text(
                            notification['data']['contact_number'],
                            style: TextStyle(
                                fontSize: 14, color: Theme.of(context).primaryColor),
                          ),
                        )
                      )
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 70,
            ),




            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child:  Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                        'Thank you in advance!', style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold
                    ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Image.asset('assets/logo.png', height: 26,),
                  ),
                ],
              ),
            ),





            SocialMediaWidget(
                description: "Blood Request \r\n\r\n"+"Blood Type: "+notification['data']['blood_type']+"\r\n"+"Hospital Name: "+notification['data']['hospital_name']+"\r\n"+"Patient Name: "+notification['data']['patient_name']+"\r\n"+"Contact Name: "+ notification['data']['contact_name']+"\r\n"+"Contact Number: "+notification['data']['contact_number'],
                //imagePath: (_image.path == null) ? "" : _image.path,
                //deeplink: deepLink,
                height: height),










          ],
        ));
  }
}
