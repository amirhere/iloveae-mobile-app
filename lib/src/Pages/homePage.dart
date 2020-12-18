import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:flutter_login_signup/src/Pages/News/newsListPage.dart';
import 'package:flutter_login_signup/src/Pages/Settings/editProfile.dart';
import 'package:flutter_login_signup/src/Pages/BusinessDirectory/jobSearchPage.dart';
import 'package:flutter_login_signup/src/Pages/SuccessStories/successStoriesListPage.dart';
import 'package:flutter_login_signup/src/Pages/Tourism/TourismSearchPage.dart';
import 'package:flutter_login_signup/src/Pages/BloodRequest/bloodRequest.dart';
import 'package:flutter_login_signup/src/Pages/Events/EventsList.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_signup/src/Pages/Notification/notificationPage.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';





import 'package:toast/toast.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String photo_url;
  String name;
  String email;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String title = "";
  String helper;


  FlutterLocalNotificationsPlugin flutterNotification =
  new FlutterLocalNotificationsPlugin();
  var androidInitialize;
  var iOSinitialize;
  var initializationSettings;


  setLocalPushNotificationSettings() {
      // for local push notification
      androidInitialize = new AndroidInitializationSettings('ic_launcher');
      iOSinitialize = new IOSInitializationSettings();

      initializationSettings = new InitializationSettings(
          android: androidInitialize, iOS: iOSinitialize);
      flutterNotification.initialize(initializationSettings);

  }


  _showNotification(reqType, patientName) async {
      var android = new AndroidNotificationDetails(
          'channel ID', 'channel name', 'channel description');
      var ios = new IOSNotificationDetails();
      var platform = new NotificationDetails(android: android, iOS: ios);

      await flutterNotification.show(0, 'Blood Request', patientName, platform);

  }



  @override
  void initState() {
    getSavedValuesFromSharedPreference();

    setLocalPushNotificationSettings();



    _firebaseMessaging.configure(onMessage: (message) async {
        setState(() {
            title = message['data']['blood_type'];
            helper = "You have received a new notification";

            _showNotification('Blood Request', message['data']['patient_name'] );

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));

        });
    }, onResume: (message) async {

        title = message['data']['patient_name'];
        helper = "You have opened  the app from notification";

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));

        // _showNotification('Blood Request', message['data']['patient_name'] );

        // //Navigator.of(context).pushReplacement(
        //  MaterialPageRoute(builder: (context) => NotificationPage(notification: message,)));

    });


  }


  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
      setState(() { _notification = state;  print("called");});
  }

  void getSavedValuesFromSharedPreference() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      photo_url = prefs.getString("photo_url").toString();
      name = prefs.getString("name").toString();
      email = prefs.getString("email").toString();
    });

    //  photo_url = "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  }

  void setLogOutStateInSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Center(
                child: Text("Home", style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            backgroundColor: Color(0xFF573555),
            actions: <Widget>[
                IconButton(
                    icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                    ),
                    onPressed: () {
                        // do something
                    },
                )
            ],
        ),
        bottomNavigationBar: new Container(
            height: 20.0,
            color: Color(0xFF573555),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Color(0xFF81687f)),
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,

              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF573555),
                  ),
                  accountName: Text(
                    "" + name + "",
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(photo_url),
                  ),
                ),
                ListTile(
                    title: Text(
                      'Edit Profile',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    onTap: () {

                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => EditProfilePage()));



                    }),
                ListTile(
                    title: Text(
                      'Terms and Conditions',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    onTap: () {}),
                ListTile(
                    title: Text(
                      'Manage Notifications',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    onTap: () {}),
                ListTile(
                    title: Text(
                      'About',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    onTap: () {}),
                ListTile(
                    title: Text(
                      'Contact Us',
                      style: TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                    onTap: () {}),
                ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                  onTap: () {
                    setLogOutStateInSharedPreference();

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: height * 0.30,
              child: Center(
                child: SizedBox.expand(
                  child: Carousel(
                    dotSize: 4.0,
                    dotSpacing: 15.0,
                    dotColor: Color(0xFF573555),
                    indicatorBgPadding: 5.0,
                    //  dotBgColor: Colors.purple.withOpacity(0.5),
                    //borderRadius: true,
                    images: [
                      ExactAssetImage("assets/banner1.png"),
                      ExactAssetImage("assets/banner2.png"),
                      ExactAssetImage("assets/banner1.png"),
                      // NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                      //   NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: height * (0.56),
              child: Scrollbar(
                  child: ListView(
                //    padding: const EdgeInsets.all(8),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewsListPage()));
                    },
                    child: Container(
                        height: 70,
                        color: Color(0xFF81687f),
                        // color: Color(0xFF6d3252),
                        child: Row(
                          children: [
                            Container(
                              width: width / 5,
                              height: 80,
                              color:  Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: new Image.asset(
                                  'assets/news_icon.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                onPressed: null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'News',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Divider(
                      color:  Theme.of(context).primaryColor,
                    height: 1,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EventsListPage()));
                    },
                    child: Container(
                        height: 70,
                        color: Color(0xFF81687f),
                        // color: Color(0xFF6d3252),
                        child: Row(
                          children: [
                            Container(
                              width: width / 5,
                              height: 80,
                                color:  Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: new Image.asset(
                                  'assets/events_icon.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                onPressed: null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Events',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Divider(
                      color:  Theme.of(context).primaryColor,
                    height: 1,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => JobCategoriesPage()));
                    },
                    child: Container(
                        height: 70,
                        color: Color(0xFF81687f),
                        // color: Color(0xFF6d3252),
                        child: Row(
                          children: [
                            Container(
                              width: width / 5,
                              height: 80,
                                color:  Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: new Image.asset(
                                  'assets/business_directory_icon.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                onPressed: null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Business Directory',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Divider(
                  color:  Theme.of(context).primaryColor,
                    height: 1,
                    thickness: 1,
                  ),
                  GestureDetector(
                      onTap:(){

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TourismSearchPage()));

                      },
                      child: Container(
                          height: 70,
                          color: Color(0xFF81687f),
                          // color: Color(0xFF6d3252),
                          child: Row(
                              children: [
                                  Container(
                                      width: width / 5,
                                      height: 80,
                                      color:  Theme.of(context).primaryColor,
                                      child: IconButton(
                                          icon: new Image.asset(
                                              'assets/tourism_icon.png',
                                              width: 30.0,
                                              height: 30.0,
                                          ),
                                          onPressed: null,
                                      ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Center(
                                          child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Color(0xFFFFFFFF), fontSize: 15),
                                                  children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'Tourism',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold)),
                                                  ],
                                              ),
                                          ),
                                      ),
                                  ),
                              ],
                          )),
                  ),
                  Divider(
                    color:   Theme.of(context).primaryColor,
                    height: 1,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SuccessStoriesListPage()));
                    },
                    child: Container(
                        height: 70,
                        color: Color(0xFF81687f),
                        // color: Color(0xFF6d3252),
                        child: Row(
                          children: [
                            Container(
                              width: width / 5,
                              height: 80,
                                color:  Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: new Image.asset(
                                  'assets/success_stories_icon.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                onPressed: null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF), fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Success Stories',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Divider(
                    color:  Theme.of(context).primaryColor,
                    height: 1,
                    thickness: 1,
                  ),

                    GestureDetector(
                        onTap: () {
                            Toast.show("This feature is currently under development!",
                                context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                        },
                        child: Container(
                            height: 70,
                            color: Color(0xFF81687f),
                            // color: Color(0xFF6d3252),
                            child: Row(
                                children: [
                                    Container(
                                        width: width / 5,
                                        height: 80,
                                        color:  Theme.of(context).primaryColor,
                                        child: IconButton(
                                            icon: new Image.asset(
                                                'assets/home/local_products.png',
                                                width: 30.0,
                                                height: 30.0,
                                            ),
                                            onPressed: null,
                                        ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Center(
                                            child: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Color(0xFFFFFFFF), fontSize: 15),
                                                    children: <TextSpan>[
                                                        TextSpan(
                                                            text: 'Local Products',
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold)),
                                                    ],
                                                ),
                                            ),
                                        ),
                                    ),
                                ],
                            )),
                    ),
                    Divider(
                        color:  Theme.of(context).primaryColor,
                        height: 1,

                        thickness: 1,
                    ),
                 GestureDetector(
                     onTap:(){
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => BloodRequestPage()));
                     },
                     child:  Container(
                         height: 70,
                         color: Color(0xFF81687f),
                         // color: Color(0xFF6d3252),
                         child: Row(
                             children: [
                                 Container(
                                     width: width / 5,
                                     height: 80,
                                     color:  Theme.of(context).primaryColor,
                                     child: IconButton(
                                         icon: new Image.asset(
                                             'assets/blood_request_icon.png',
                                             width: 30.0,
                                             height: 30.0,
                                         ),
                                         onPressed: null,
                                     ),
                                 ),
                                 Padding(
                                     padding: EdgeInsets.only(left: 30),
                                     child: Center(
                                         child: RichText(
                                             text: TextSpan(
                                                 style: TextStyle(
                                                     color: Color(0xFFFFFFFF), fontSize: 15),
                                                 children: <TextSpan>[
                                                     TextSpan(
                                                         text: 'Blood Request',
                                                         style: TextStyle(
                                                             fontWeight: FontWeight.bold)),
                                                 ],
                                             ),
                                         ),
                                     ),
                                 ),
                             ],
                         )),
                 ),
                ],
              )),
            ),
          ],
        ));
  }
}
