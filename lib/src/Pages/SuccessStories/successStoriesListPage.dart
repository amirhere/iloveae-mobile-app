import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:convert';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/listViewTileWidget.dart';
import 'package:flutter_login_signup/src/Pages/SuccessStories/successStoryPage.dart';
import 'package:flutter_login_signup/src/Models/SuccessStory.dart';

import 'package:load/load.dart';
import 'package:jiffy/jiffy.dart';


class SuccessStoriesListPage extends StatefulWidget {
  SuccessStoriesListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SuccessStoriesListPageState createState() => _SuccessStoriesListPageState();
}

class _SuccessStoriesListPageState extends State<SuccessStoriesListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> data;
  List dataArray;

  @override
  void initState() {
    getDataFromHttpRequest();
  }

  void getDataFromHttpRequest() async {
    showLoadingDialog();

    final http.Response response = await http.post(
      Helper.show_success_stories,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Helper.access_token
      },
    );

    hideLoadingDialog();

    print(response.body);
    data = json.decode(response.body);

    setState(() {
      dataArray = data['success_stories'];
      print(dataArray);
    });
  }

  Widget getCarouselWidget(double height) {
    return Container(
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
            images: [
              //  ExactAssetImage("assets/banner1.png"),
              //   ExactAssetImage("assets/banner2.png"),
              //  ExactAssetImage("assets/banner1.png"),
              NetworkImage(
                  'https://c.files.bbci.co.uk/8238/production/_113963333_062930447.jpg'),
              NetworkImage(
                  'https://i.ytimg.com/vi/HlEFrbLeDks/maxresdefault.jpg'),
              NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQiZ5txPdZBmES7mBciInO5S6BV7HDHdm7exg&usqp=CAU'),
              NetworkImage(
                  'https://c.files.bbci.co.uk/5A67/production/_109934132_final-final-feat.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListViewWidget(double height, double width, var dataArray) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: ListView.builder(
          itemCount: dataArray == null ? 0 : dataArray.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SuccessStoryPage(
                        title: dataArray[index]["title"],
                        authorName: dataArray[index]["author_name"],
                        storyTitle: dataArray[index]["story_title"],
                        authorTitle: dataArray[index]["author_title"],
                        description: dataArray[index]["description"],
                        authorThumbnail: dataArray[index]["thumbnail"],
                        images: dataArray[index]["success_story_images"]),
                  ),
                );
              },
              child: ListViewTileWidget(
                  height: height ,
                  width: width,
                  dataArray: dataArray,
                  index: index,
              ),
            );
          },
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Success Story",
        height: height,
        width: width / 5,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: height,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getCarouselWidget(height),
              (dataArray != null)
                  ? getListViewWidget(height, width, dataArray)
                  : Padding(
                      padding: EdgeInsets.only(top: height / 4.5),
                      child: Center(
                        child: Text(
                          'No records found.',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
