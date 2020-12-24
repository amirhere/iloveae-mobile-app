import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Pages/welcomePage.dart';
import 'dart:ui';





void main(){



    runApp(
        LoadingProvider(
            themeData: LoadingThemeData(),
            loadingWidgetBuilder: (ctx, data) {
                return Center(
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: Container(
                            child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))

                            // color: Colors.white,
                        ),
                    ),
                );
            },

            child: MyApp(),
        ),

    );




}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         // primaryColor: Color(0xFF573555),
          primaryColor: Color(0xFF573555),
          accentColor: Color(0xff84849d),
          backgroundColor: Color(0xffc7dceb),




         toggleableActiveColor: Color(0xFF6A596D),
         primarySwatch: Colors.lightBlue,

         visualDensity: VisualDensity.adaptivePlatformDensity,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
