import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'dart:io';


import 'package:flutter_login_signup/src/Pages/Settings/editProfile.dart';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Widgets/socialMedia.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

import 'package:flutter_login_signup/src/Pages/News/newsListPage.dart';
import 'package:flutter_html/flutter_html.dart';


class NewsPage extends StatefulWidget {
  String title;
  String description;
  String deepLink;
  List images;
  File _image;

  NewsPage({this.title, this.description, this.images, this.deepLink});

  @override
  _NewsPageState createState() =>
      _NewsPageState(title, description, images, deepLink);
}

class _NewsPageState extends State<NewsPage> {
  String title, description, deepLink;
  List images;
  List<NetworkImage> networkImagesList = List<NetworkImage>();
  File _image;
  String _text;

  final ScrollController scrollController = ScrollController();

  _NewsPageState(this.title, this.description, this.images, this.deepLink) {
    for (int loop = 0; loop < images.length; loop++) {
      Map resp = images[loop];
      print(resp['url']);
      networkImagesList.add(NetworkImage(resp['url']));


    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String photo_url;
  String name;
  String email;
  double carouselHeight, contentHeight;

  @override
  void initState() {
    getSavedValuesFromSharedPreference();
    super.initState();

    _text = 'Swipe me!';


        urlToFile('https://pitstopsystems.com/iloveae/logo.png');




  }

  urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(imageUrl);
    await file.writeAsBytes(response.bodyBytes);

    setState(() {
      _image = file;
    });
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
        appBar: CustomAppBar(
          title: "News",
          height: height,
          width: width / 3.8,
          // height: 200,
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfilePage()));
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
        body: CustomScrollView(
            slivers: <Widget>[

                SliverAppBar(
                    backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                    expandedHeight: height * (1 / 3),
                    elevation: 0,
                    leading: new Container(),
                    //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Hero(
                            tag: 'hero tag',
                            child: Container(
                                height: height * (1 / 3),
                                child: Center(
                                    child: SizedBox.expand(
                                        child: Carousel(
                                            dotSize: 4.0,
                                            dotSpacing: 15.0,
                                            dotColor: Color(0xFF573555),
                                            indicatorBgPadding: 5.0,
                                            //  dotBgColor: Colors.purple.withOpacity(0.5),
                                            //borderRadius: true,
                                            images: networkImagesList ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                ),

                SliverToBoxAdapter(
                    child:   Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                            Material(
                                elevation: 4,
                                child: Container(
                                    width: width,
                                    padding: EdgeInsets.only(left: 30, top: 15, bottom: 15),
                                    color: Theme.of(context).backgroundColor,
                                    //   color: Theme.of(context).backgroundColor,
                                   // height: height * (0.25 / 3),
                                    child: Text(
                                        title,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColor),
                                    ),
                                ),
                            ),
                            Container(
                             //   height: contentHeight,
                                width: width,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                padding: EdgeInsets.only(top: 30),
                                child: /*Text(
                                    description,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                ),*/
                                Html(data: description),
                            ),


                            SizedBox(height: 10),
                            SocialMediaWidget(
                                description: description,
                                //imagePath: (_image.path == null) ? "" : _image.path,
                                deeplink: deepLink,
                                height: height),
                            SizedBox(height: 10),

                        ],
                    ),

                )

            ],
        ));
  }






}
