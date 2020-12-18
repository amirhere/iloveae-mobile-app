import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Widgets/socialMedia.dart';
import 'package:flutter_login_signup/src/Widgets/carouselWidget.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';

import 'package:flutter_login_signup/src/Pages/News/newsListPage.dart';

class SuccessStoryPage extends StatefulWidget {
  String _platformVersion = 'Unknown';

  String title;
  String description;
  String storyTitle;
  String authorTitle, authorThumbnail;
  String authorName;
  List images;

  SuccessStoryPage(
      {this.title,
      this.description,
      this.images,
      this.storyTitle,
      this.authorName,
      this.authorTitle,
      this.authorThumbnail});

  @override
  _SuccessStoryPage createState() => _SuccessStoryPage(title, description,
      images, storyTitle, authorName, authorTitle, authorThumbnail);
}

class _SuccessStoryPage extends State<SuccessStoryPage> {
  String title,
      description,
      storyTitle,
      authorName,
      authorTitle,
      authorThumbnail,
      socialMediaStoryImage;
  List images;
  File _image;
  List<NetworkImage> networkImagesList = List<NetworkImage>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String photo_url;
  String name;
  String email;

  @override
  void initState() {
    getSavedValuesFromSharedPreference();
  }

  _SuccessStoryPage(this.title, this.description, this.images, this.storyTitle,
      this.authorName, this.authorTitle, this.authorThumbnail) {
    for (int loop = 0; loop < images.length; loop++) {
      Map resp = images[loop];
      print(resp['url']);
      networkImagesList.add(NetworkImage(resp['url']));

      if (loop == 0) {
        urlToFile(resp['url']);

        //    urlToFile(
        //      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSSWcXRYK-BfnFik6SKtMxYo-fuGDWJDOQCAw&usqp=CAU");
      }
    }
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
      appBar: CustomAppBar(
        title: "Success Story",
        height: height,
        width: width / 5.5,
        // height: 200,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: height,
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
                      child: CarouselWidget(
                        height: height,
                        networkImagesList: networkImagesList,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

            SliverToBoxAdapter(
                child:    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      Material(
                          elevation: 4,
                          child:   Container(
                              width: width,

                              padding: EdgeInsets.only(left: 30, top: 8, bottom: 8),
                              color: Theme.of(context).backgroundColor,
                              //   color: Theme.of(context).backgroundColor,
                            //  height: height * (0.25 / 3),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                      Container(
                                          child:
                                          Text(
                                              title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context).primaryColor),
                                          ),
                                      ),

                                      Container(
                                          child: Text(
                                              storyTitle,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).primaryColor),
                                          ),
                                      ),

                                  ],
                              ),
                          ),
                      ),

                        SizedBox(height: 10),
                        Container(
                            //   width: width,
                            //  color: Colors.blue,
                            padding: EdgeInsets.only(left: 30, top: 8),
                            //   color: Theme.of(context).backgroundColor,
                            height: height * (0.25 / 3),
                            child: Row(
                                children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(authorThumbnail),
                                    ),

                                    SizedBox(
                                        width: 20,
                                    ),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            SizedBox(
                                                height: 10,
                                            ),
                                            Text(
                                                "by " + authorName,
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                authorTitle,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                            )
                                        ],
                                    ),
                                ],
                            ),
                        ),
                        Container(
                            //  color: Colors.red,

                            width: width,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                                description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                        ),
                        SizedBox(
                            height: 10,
                        ),
                        SocialMediaWidget(
                            description: description,
                           // imagePath: _image.path,
                            deeplink: "https://www.entrepreneur.com/article/240492",
                            height: height),
                        SizedBox(
                            height: 10,
                        ),
                    ],
                )


            ),
        ],
      ),
    );
  }

/* build_content() {
    Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CarouselWidget(
              height: height,
              networkImagesList: networkImagesList,
            ),
            Container(
              width: width,

              padding: EdgeInsets.only(left: 30, top: 8),
              color: Theme.of(context).backgroundColor,
              //   color: Theme.of(context).backgroundColor,
              height: height * (0.25 / 3),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        storyTitle,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              //   width: width,
              //  color: Colors.blue,
              padding: EdgeInsets.only(left: 30, top: 8),
              //   color: Theme.of(context).backgroundColor,
              height: height * (0.25 / 3),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(authorThumbnail),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "by " + authorName,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        authorTitle,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              //  color: Colors.red,
              height: height * (1 / 3.1),
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.only(top: 5),
              child: SingleChildScrollView(
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SocialMediaWidget(
                description: description,
                imagePath: _image.path,
                deeplink: "https://www.entrepreneur.com/article/240492",
                height: height),
          ],
        )
      ],
    );
  }*/
}
