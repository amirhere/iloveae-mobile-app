import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Pages/BusinessDirectory/jobResultPage.dart';
import 'package:toast/toast.dart';

import 'package:load/load.dart';




class JobCategoriesPage extends StatefulWidget {
  JobCategoriesPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JobCategoriesPageState createState() => _JobCategoriesPageState();
}

class _JobCategoriesPageState extends State<JobCategoriesPage> {

    Map data;
    List jobsData = null;

    bool isListViewVisible = false;

    TextEditingController keywordTextEditingController =
    new TextEditingController();


    @override
    void initState() {
    }


  Widget getSearchBarWidget(double height, double width) {
    return Container(
      // color: Colors.orange,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: width * 0.11,  ),
      child: Column(
        children: <Widget>[
            SizedBox(height: height * 0.22),
          Align(
              alignment: Alignment.topLeft,
              child: Text("What can we find for you?",
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600
                  ),
              ),
          ),

            SizedBox(height: height * 0.04,),

          Container(
            height: height * 0.35,
            child:
            Material(
                elevation: 5.0,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(0),
                child: TextField(
                    controller: keywordTextEditingController,
                    onSubmitted: (String text) {
                        setState(() {
                            showLoadingDialog();
                            makeJobSearchRequest2(keywordTextEditingController.text);

                        });
                    },

                    keyboardType: TextInputType.text,
                    cursorColor: Color(0xFF573555),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                            ),
                        ),
                        labelStyle: TextStyle(
                            color: Color(0xFF573555), fontWeight: FontWeight.w600),
                      ),
                ),
            ),
          ),

            //SizedBox(height: height * 0.08,),
        ],
      ),
    );
  }

  Widget getCustomGridTileWidget(
      double width, double height, String title, String icon, Color color) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
            width: width * 0.44,
            height: width * 0.44,
            color: color,

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(
                        height: height * 0.08,
                    ),
                    Image.asset(
                        icon,
                        color: Colors.white,
                        height: height * 0.17,
                        width: width * 0.17,
                    ),
                    SizedBox(
                        height: height * 0.05,
                    ),
                    Text(
                        title,
                        style: TextStyle(fontSize: width * 0.040, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                ],
            ),
        ),
    );
  }

  Widget getCustomGridOddRowWidget(double width, double height, String title,
      String icon, String title2, String icon2, String title3, String icon3, ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          GestureDetector(
              onTap: (){
                  showLoadingDialog();
                  makeJobSearchRequest(title);
              },
              child: getCustomGridTileWidget(width , height, title2, icon2, Theme.of(context).primaryColor),
          ),

          GestureDetector(
              onTap: (){
                  showLoadingDialog();
                  makeJobSearchRequest(title);
              },
              child: getCustomGridTileWidget(width , height, title3, icon3, Theme.of(context).primaryColor),
          ),


          GestureDetector(
              onTap: (){
                  showLoadingDialog();
                  makeJobSearchRequest(title);
              },
              child: getCustomGridTileWidget(width , height, title, icon, Theme.of(context).primaryColor),
          ),


            /*GestureDetector(
                onTap: (){
                    showLoadingDialog();
                    makeJobSearchRequest(title2);
                },
                child:  getCustomGridTileWidget(width, height, title2, icon2, Theme.of(context).accentColor),

      )*/

      ],
    );
  }


  Widget getCustomGridEvenRowWidget(double width, double height, String title,
      String icon, String title2, String icon2) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              /*GestureDetector(
                  onTap: (){
                      showLoadingDialog();
                      makeJobSearchRequest(title);
                  },
                  child: getCustomGridTileWidget(width, height, title, icon, Theme.of(context).accentColor),
              ),*/



             GestureDetector(
                  onTap: (){
                      showLoadingDialog();
                      makeJobSearchRequest(title2);
                  },
                  child:  getCustomGridTileWidget(width, height, title2, icon2, Theme.of(context).primaryColor),

              ),

              GestureDetector(
                  onTap: (){
                      showLoadingDialog();
                      makeJobSearchRequest(title2);
                  },
                  child:  getCustomGridTileWidget(width, height, title2, icon2, Theme.of(context).primaryColor),

              ),

              GestureDetector(
                  onTap: (){
                      showLoadingDialog();
                      makeJobSearchRequest(title2);
                  },
                  child:  getCustomGridTileWidget(width, height, title2, icon2, Theme.of(context).primaryColor),

              )



          ],
      );
  }

  Widget getGridView(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: height * 0.80,

          child: Scrollbar(
              child: ListView(
            children: <Widget>[


                Container(
                    // color:Colors.yellow,
                    //  height:  width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.11),
                    child: getCustomGridOddRowWidget(
                        width * 0.57,
                        width * 0.57,
                        "Accounting/Finance",
                        "assets/email_icon.png",
                        "Administrative",
                        "assets/email_icon.png",
                        "Advertising",
                        "assets/email_icon.png"),
                ),
                SizedBox(
                    height: height * 0.009,
                ),

                Container(
                    // color:Colors.yellow,
                    //  height:  width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.11),
                    child: getCustomGridOddRowWidget(
                        width * 0.57,
                        width * 0.57,
                        "Agriculture",
                        "assets/email_icon.png",
                        "Architecture",
                        "assets/email_icon.png",
                        "Artist/Actor/Performer",
                        "assets/email_icon.png"),
                ),
                SizedBox(
                    height: height * 0.009,
                ),
                Container(
                    // color:Colors.yellow,
                    //  height:  width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.11),
                    child: getCustomGridOddRowWidget(
                        width * 0.57,
                        width * 0.57,
                        "Aviatory/Airlines",
                        "assets/email_icon.png",
                        "Administrative",
                        "assets/email_icon.png",
                        "Administrative",
                        "assets/email_icon.png"),
                ),
                SizedBox(
                    height: height * 0.009,
                ),

                Container(
                    // color:Colors.yellow,
                    //  height:  width * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.11),
                    child: getCustomGridOddRowWidget(
                        width * 0.57,
                        width * 0.57,
                        "Accounting/Finance",
                        "assets/email_icon.png",
                        "Administrative",
                        "assets/email_icon.png",
                        "Administrative",
                        "assets/email_icon.png"),
                ),
                SizedBox(
                    height: height * 0.009,
                ),


              /*
              Container(
                 // height: height * 0.27,

                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: getCustomGridEvenRowWidget(
                    width * 0.59,
                    width * 0.59,
                    "Advertising",
                    "assets/email_icon.png",
                    "Agriculture",
                    "assets/email_icon.png"),
              ),*/
              /*SizedBox(
                height: height * 0.03,
              ),*/
              /*Container(
                 // height: height * 0.27,

                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: getCustomGridOddRowWidget(
                    width * 0.59,
                    width * 0.59,
                    "Architecture",
                    "assets/email_icon.png",
                    "Artist/Actor/Performer",
                    "assets/email_icon.png"),
              ),*/
             /* SizedBox(
                height: height * 0.03,
              ),*/
              /*Container(
                 // height: height * 0.27,

                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: getCustomGridEvenRowWidget(
                    width * 0.59,
                    width * 0.59,
                    "Aviatory/Airlines",
                    "assets/email_icon.png",
                    "Banking/Financial",
                    "assets/email_icon.png"),
              ),*/
            ],
          ),
          ),
        ),
      ],
    );
  }






    void makeJobSearchRequest2(String searchedKeyword) async {


        final http.Response response = await http.post(
            Helper.searched_business_listing,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': Helper.access_token
            },
            body: jsonEncode(<String, String>{
                'name': searchedKeyword,
            }),
        );

        setState(() {
            //isProgressBarVisible = false;
        });

        print(response.body);

        hideLoadingDialog();

        Map resp = json.decode(response.body);
        if (resp['status'].toString() == "true") {
            print(resp['jobs'].toString());


            setState((){
                jobsData = resp['jobs'];
            });




            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JobResultPage(
                    category: searchedKeyword,
                    jobsData: resp['jobs'],

                )));



        } else {
            //  Toast.show(resp['message'].toString(), context,
            //    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
    }






    void makeJobSearchRequest(String searchedKeyword) async {
      setState(() {
        //  isProgressBarVisible = true;
      });

      final http.Response response = await http.post(
          Helper.category_business_listing,
          headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': Helper.access_token
          },
          body: jsonEncode(<String, String>{
              'category': searchedKeyword,
          }),
      );

      setState(() {
          //isProgressBarVisible = false;
      });

      print(response.body);

      hideLoadingDialog();

      Map resp = json.decode(response.body);
      if (resp['status'].toString() == "true") {
          print(resp['jobs'].toString());


          setState((){
              jobsData = resp['jobs'];
          });




          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => JobResultPage(
                  category: searchedKeyword,
                  jobsData: resp['jobs'],

                 )));



      } else {
        //  Toast.show(resp['message'].toString(), context,
          //    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
  }






    Widget getListViewWidget(double height, double width, var dataArray) {
        return ListView.builder(
            itemCount: dataArray == null ? 0 : dataArray.length,
            itemBuilder: (BuildContext context, int index) {
                return Expanded(
                    child: Card(
                        child: Row(
                            children: <Widget>[
                                Container(
                                    height: 500,
                                   // width: width / 4,
                                    child: Image(
                                        image: NetworkImage(dataArray[index]["photo_url"]),
                                        fit: BoxFit.fill,

                                        // backgroundImage: NetworkImage(userData['thumbnail']),
                                    ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                        children: <Widget>[
                                            ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    minWidth: 280.0,
                                                    maxWidth: 280.0,
                                                    minHeight: 10.0,
                                                    maxHeight: 50.0,
                                                ),
                                                child: Text(
                                                    dataArray[index]["name"],

                                                    style: TextStyle(fontWeight: FontWeight.bold),

                                                    //overflow: TextOverflow.clip,
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: 3, left: width * 0.40),
                                                child: Text(
                                                    dataArray[index]["designation"],
                                                    // Jiffy(dataArray[index]["created_at"]).fromNow(),

                                                    style: TextStyle(fontWeight: FontWeight.w100),

                                                    //overflow: TextOverflow.clip,
                                                ),
                                            )
                                        ],
                                    ),
                                )
                            ],
                        ),
                    ),
                );
            },
        );
    }


    @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
          title: 'Business Directory',
          height: height,
          width: width * 0.12,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          height: height,
        ),
        body: new GestureDetector(
          onTap: ()=> FocusScope.of(context).requestFocus(new FocusNode()),
          child: Container(
            child: Column(
              children: <Widget>[

                getSearchBarWidget(height * 0.17, width),
                getGridView(height * 0.845, width),

                //    getGridView(height * 0.88, width),
              ],
            ),
          ),
        ));
  }
}
