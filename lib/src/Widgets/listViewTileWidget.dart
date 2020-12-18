import 'dart:math';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/material.dart';

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
    Size get preferredSize => Size.fromHeight(height );

    @override
    Widget build(BuildContext context) {
        return  Container(
            padding: EdgeInsets.only(left:10, right: 10, top:5, bottom:5),
         //   color: Colors.green,
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            Container(
                                height: height * 0.12,
                                width: width *0.30,
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
                                                        dataArray[index]["description"],
                                                        style: TextStyle(fontSize: 12 ,fontWeight: FontWeight.bold),

                                                    ),
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
                   SizedBox(
                       height: 10,
                   ),
                   Padding(
                       padding: EdgeInsets.symmetric(horizontal: 20),
                       child:  Divider(
                           thickness: 1,
                           height: 0.5,

                           color: Theme.of(context).primaryColor,
                       ),
                   ),
                ],
            )
        );
    }
}
