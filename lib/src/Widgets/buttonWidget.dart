import 'dart:math';

import 'package:flutter/material.dart';

class ButtonWidget extends PreferredSize {



    final String label;



    ButtonWidget({
        @required  this.label,
    });





    @override
    Widget build(BuildContext context) {
         final height =  MediaQuery.of(context).size.height;
         final width =  MediaQuery.of(context).size.width;

        return Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.14),
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            alignment: Alignment.center,
            color: Theme.of(context).accentColor,

            child: RichText(
                text: new TextSpan(
                    text: label,
                    style: new TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor,
                    ),
                ),
            ),
        );
    }
}
