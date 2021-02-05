import 'dart:math';

import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {


    final double height;
    final double width;
    final String title;
   // final bool isHomePage;


    CustomAppBar({
        @required  this.title,
        this.height = kToolbarHeight,
        this.width = kToolbarHeight,
       // this.isHomePage,
    });



    @override
    Size get preferredSize => Size.fromHeight(height/12);

    @override
    Widget build(BuildContext context) {

        return AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title:  Text(
                title,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 15
                ),
            ),

            actions: <Widget>[

            (title == "Home") ?
                IconButton(
                    icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                    ),
                    onPressed: () {
                        // do something
                    },
                ): SizedBox()

            ],
           
            leading: (title != 'Login' || title !=  'Notification' )?
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Color(0xFFFFFFFF),
                onPressed: () => Navigator.pop(context, false),
            ):SizedBox()
        );
    }
}
