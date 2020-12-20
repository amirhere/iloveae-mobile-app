import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jiffy/jiffy.dart';


import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Pages/Events/EventPage.dart';


class EventsListPage extends StatefulWidget {
  EventsListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EventsListPageState createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  Map<String, dynamic> map;
  List<Event> eventsDataList;
  List<Event> eventsDataList2;
  bool isFavorite = false;

  @override
  void initState() {
    getData();
  }


  void getData() async {
    showLoadingDialog();

    final http.Response response = await http.post(
      Helper.show_events,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Helper.access_token
      },
    );

    hideLoadingDialog();

    map = json.decode(response.body);
    List<dynamic> data = map["events"];

    print(data);



    setState(() {
       eventsDataList = data.map((val) =>  Event.fromJson(val)).toList();

       Event event =  eventsDataList[0];
       print('-=-=-=-=-=-=-=-=-');
       print(event.date);
       print('-=-=-=-=-=-=-=-=-');


    });


  }

  Widget getListViewWidget(double height, double width, var dataArray) {
    return ListView.builder(
      itemCount: dataArray == null ? 0 : dataArray.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EventPage(
                    title: dataArray[index].title,
                    description: dataArray[index].description,
                    deepLink: "deeplink",
                    date: dataArray[index].date,
                    images: dataArray[index].event_images),
              ),
            );
          },
          child: getEventTileWidget(width, dataArray[index].title,
              dataArray[index].thumbnail, dataArray[index].date,  dataArray[index].isLiked),
        );
      },
    );
  }

  Widget getEventTileWidget(width, title, thumbnail, date, isLiked) {
    return Stack(
      //  alignment: Alignment.bottomCenter,
      overflow: Overflow.visible,
      children: [
        Container(
          height: 215,
          child: FittedBox(
            child: Image.network(thumbnail),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: width * 0.13,
          top: 50,
          child: Container(
            child: (isFavorite)
                ? IconButton(
                    icon: new Image.asset("assets/event/heart_white.png"),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  )
                : IconButton(
                    icon: new Image.asset("assets/event/heart_red.png"),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
          ),
        ),
        Positioned(
            top: 145,
            child: Material(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.09),
                height: 70,
                width: width,
                color: Theme.of(context).backgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: new Image.asset(
                            'assets/dob_icon.png',
                            width: 60.0,
                            height: 60.0,
                          ),
                          onPressed: () {
                            print('do nothing...!');
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 17),
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              "wow",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 140),
              child: Container(
                height: 80,
                width: width * 0.22,
                margin: EdgeInsets.only(left: width * 0.70),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "days until",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      Helper.timeDifferenceCalculator(date),
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.yellow,
      appBar: CustomAppBar(
        title: 'Events',
        height: height,
        width: width * 0.12,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: height,
      ),
      body: Stack(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // getCarouselWidget(height),
          (eventsDataList != null)
              ? getListViewWidget(height, width, eventsDataList)
              : Center(
                  child: Text(
                    'No events found.',
                    style: TextStyle(fontSize: 25),
                  ),
                )
        ],
      ),
    );
  }
}




class Event {
  String title;
  String thumbnail;
  String date;
  String description;
  String isLiked;
  var eventImages;


  Event(
      {this.title,
        this.thumbnail,
        this.date,
        this.description,
        this.isLiked,
        this.eventImages,

      });


  Event.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnail = json['thumbnail'];
    date = json['date'];
    description = json['description'];
    isLiked =  json['isLiked'];
    eventImages = json['event_images'];


  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['date'] = this.date;
    data['description'] = this.description;
    data['isLiked'] = this.isLiked;
    data['event_images'] = this.eventImages;
    return data;
  }



/*

    int StringToIntConverter(String number){
        var myInt = int.parse('12345');
        assert(myInt is int);
        print(myInt); // 12345
        return myInt;
    }*/

}