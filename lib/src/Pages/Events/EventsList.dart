import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:toast/toast.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Pages/Events/EventPage.dart';
import 'package:flutter_login_signup/src/Models/Event/Event.dart';

class EventsListPage extends StatefulWidget {
  EventsListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EventsListPageState createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  Map<String, dynamic> map;
  List<Event> eventsDataList;

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

    setState(
      () {
        eventsDataList = data.map((val) => Event.fromJson(val)).toList();
        for(var loop = 0; loop < eventsDataList.length; loop++){
         Event event =  eventsDataList.elementAt(loop);

          if(Helper.timeDifferenceCalculator(event.date).contains("-")){
            eventsDataList.remove(event);
            eventsDataList.add(event);
          }

        }




      },
    );
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
                    images: dataArray[index].eventImages),
              ),
            );
          },
          onDoubleTap: () {},
          child: getEventTileWidget(width, dataArray[index]),
        );
      },
    );
  }

  Widget getEventTileWidget(width, event) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          if (event.isLiked == "true") {
            event.isLiked = "false";

            Toast.show(
                "Notifications for " + event.title + " disabled", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          } else {
            event.isLiked = "true";

            Toast.show("Notifications for " + event.title + " enabled", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        });
      },


      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 215,
            child: FittedBox(
              child: Image.network(event.thumbnail),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            right: width * 0.13,
            top: 50,
            child: Container(
              child: (event.isLiked == "false")
                  ? IconButton(
                      icon: new Image.asset("assets/event/heart_white.png"),
                      onPressed: () {
                         setState(() {
                    event.isLiked = "true";

                    Toast.show(
                        "Notifications for " + event.title + " enabled",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  });
                      },
                    )
                  : IconButton(
                      icon: new Image.asset("assets/event/heart_red.png"),
                      onPressed: () {
                        setState(() {
                    event.isLiked = "false";

                    Toast.show(
                        "Notifications for " + event.title + " disabled",
                        context,
                        duration: Toast.LENGTH_LONG,
                        gravity: Toast.BOTTOM);
                  });
                      },
                    ),
            ),
          ),
          Positioned(
            top: 149,
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
                              event.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                            Text(
                              event.date,
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
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 140),
                child: Container(
                  height: 80,
                  width: width * 0.22,
                  margin: EdgeInsets.only(left: width * 0.70),
                  color: Theme.of(context).primaryColor,
                  child: (Helper.timeDifferenceCalculator(event.date).contains("-")) ? Container( height:20, width:20,child: Image.asset("assets/event/checked.png"),):
                  Column(
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
                        Helper.timeDifferenceCalculator(event.date),
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )

                ),
              ),
            ],
          ),
        ],
      ),
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
