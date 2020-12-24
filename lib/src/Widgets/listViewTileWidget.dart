import 'dart:math';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class ListViewTileWidget extends PreferredSize {
  final double height;
  final double width;
  final int index;
  List dataArray;

  // final bool isHomePage;

  ListViewTileWidget({
    this.index,
    this.dataArray,
    this.height = kToolbarHeight,
    this.width = kToolbarHeight,
    // this.isHomePage,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
     /*   border: Border.all(
            color: Colors.pink[800], // set border color
            width: 3.0), */

        border: Border(
          bottom: BorderSide( //                   <--- left side
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),

        // set border width
        // set rounded corner radius
      ),

      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      padding: EdgeInsets.only(bottom: 14, top: 5),
      //   color: Colors.green,
      child: Row(
        children: <Widget>[
          Container(
            height: height * 0.12,
            width: width * 0.30,
            child: Image(
              image: NetworkImage(dataArray[index]["thumbnail"]),
              fit: BoxFit.fill,
            ),
          ),
          Flexible(
            child: Container(
              width: width * 0.65,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      dataArray[index]["title"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 5),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: width * 0.66,
                        maxHeight: 43,
                      ),
                      child: Text(
                        (dataArray[index]["brief_desc"] == null) ? dataArray[index]["description"] : dataArray[index]["brief_desc"],
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    //  Html(data: dataArray[index]["description"]),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      Jiffy(dataArray[index]["created_at"]).fromNow(),
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 0,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
