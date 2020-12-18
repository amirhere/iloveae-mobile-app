import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';


class SocialMediaWidget extends PreferredSize {


    final double height;
    final String imagePath;
    final String description;
    final String deeplink;

    SocialMediaWidget({
        @required  this.imagePath,
        @required  this.description,
        @required  this.deeplink,

        this.height = kToolbarHeight,

       // this.isHomePage,
    });



    @override
    Size get preferredSize => Size.fromHeight(height/12);

    @override
    Widget build(BuildContext context) {

        return Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                    GestureDetector(
                        onTap: (){
                            SocialShare.shareOptions(description,
                                imagePath: imagePath);
                        },
                        child: Image.asset(
                            'assets/social_media/pinterest.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                    ),


                    SizedBox(
                        width: 5,
                    ),

                    GestureDetector(
                        onTap: (){
                            SocialShare.shareFacebookStory(imagePath, '#ffffff',
                                "#000000", deeplink,
                                appId: "418748446193185");
                        },
                        child: Image.asset(
                            'assets/social_media/facebook.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                    ),


                    SizedBox(
                        width: 5,
                    ),

                    GestureDetector(
                        onTap: (){
                            SocialShare.shareInstagramStory(
                                imagePath,
                                "#ffffff",
                                "#000000",
                                deeplink);
                        },
                        child: Image.asset(
                            'assets/social_media/instagram.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                    ),


        SizedBox(
        width: 5,
        ),

                    GestureDetector(
                        onTap: (){
                            SocialShare.shareWhatsapp(description);

                        },
                        child: Image.asset(
                            'assets/social_media/whatsapp.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                    ),



                    SizedBox(
                        width: 20,
                    )
                ],
            ),
        );
    }
}
