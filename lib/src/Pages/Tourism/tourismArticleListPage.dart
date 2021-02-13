import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_login_signup/src/Widgets/listViewTileWidget.dart';
import 'package:flutter_login_signup/src/Pages/Tourism/tourismArticlePage.dart';

import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Utils/HttpHelper.dart';


class TourismArticleListPage extends StatefulWidget {
  String category, searchBy;

  TourismArticleListPage({Key key, this.category, this.searchBy})
      : super(key: key);

  @override
  _TourismArticleListPageState createState() =>
      _TourismArticleListPageState(category, searchBy);
}

class _TourismArticleListPageState extends State<TourismArticleListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String category;
  String searchBy;

  Map<String, dynamic> data;
  List dataArray;
  List<NetworkImage> networkImagesList = List<NetworkImage>();


  _TourismArticleListPageState(this.category, this.searchBy) {
    //do nothing...
  }

  @override
  void initState() {
    getDataFromHttpRequest();
  }

  void getDataFromHttpRequest() async {
    showLoadingDialog();

    final http.Response response = await http.post(
      (this.searchBy == 'category')
          ? Helper.category_tourism_activities_listing
          : Helper.searched_tourism_activities_listing,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Helper.access_token
      },
      body: jsonEncode(<String, String>{'name': category}),
    );

    hideLoadingDialog();

    print(response.body);
    data = json.decode(response.body);

    setState(() {
      dataArray = data['jobs'];
      print(dataArray);
    });
  }

  Widget getCarouselWidget(double height) {
    return Container(
      height: height * (1 / 3),
      child: Center(
        child: SizedBox.expand(
          child: FutureBuilder(
            future: HttpHelper.makeThingsToDoGalleryImagesRequest(),
            builder: (BuildContext context, AsyncSnapshot snapshot){

            //  networkImagesList.add(NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7f/Dani_Daniels_AEE_2013.jpg'));

              for(var loop = 0;loop < snapshot.data['images'].length; loop++){
                print(snapshot.data['images'][loop]);

                networkImagesList.add(NetworkImage(snapshot.data['images'][loop]));
              }


              if(snapshot.connectionState != ConnectionState.done){
                return Container(); // your widget while loading
              }

              if(!snapshot.hasData){
                return Container(); //your widget when error happens
              }

              return Carousel(
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotColor: Color(0xFF573555),
                indicatorBgPadding: 5.0,
                images:  networkImagesList,
              );
            },
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TourismArticlePage(
                        title: dataArray[index]["title"],
                        description: dataArray[index]["description"],
                        images: dataArray[index]["tourism_images"])));
              },
              child: ListViewTileWidget(
                  height: height,
                  width: width,
                  dataArray: dataArray,
                  index: index),
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
        title: "Tourism",
        height: height,
        width: width / 4,
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
