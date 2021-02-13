import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:convert';

import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';

import 'package:flutter_login_signup/src/Pages/News/newsPage.dart';
import 'package:flutter_login_signup/src/Pages/Settings/editProfile.dart';
import 'package:flutter_login_signup/src/Widgets/listViewTileWidget.dart';


import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Utils/HttpHelper.dart';




class NewsListPage extends StatefulWidget {
  NewsListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String photo_url;
  String name;
  String email;
  List<NetworkImage> networkImagesList = List<NetworkImage>();

  Map data;
  List allNewsData;
  List municipalityNewsData;
  List communityNewsData;

  @override
  void initState() {
    getSavedValuesFromSharedPreference();

    getData();
  }

  void getData() async {
      showLoadingDialog();

    final http.Response response = await http.post(
      Helper.show_news,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': Helper.access_token
      },
      body: jsonEncode(<String, String>{
        //'email': userNameTextEditingController.text,
        //'password': passwordTextEditingController.text
      }),
    );

      showLoadingDialog();

    print(response.body);

    data = json.decode(response.body);

    setState(() {
      allNewsData = data['all_news'];
      municipalityNewsData = data['municpal_news'];
      communityNewsData = data['community_news'];
      // userData.reversed.toList();

      // print(userData);
    });

    /*
        Map resp = json.decode(response.body);
        if (resp['status'].toString() == "true") {
            print(resp['token'].toString());
            print(resp['user']['name'].toString());

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', resp['token'].toString());
            prefs.setString('name', resp['user']['name'].toString());
            prefs.setString('nick_name', resp['user']['nick_name'].toString());
            prefs.setString('family_name', resp['user']['family_name'].toString());
            prefs.setString('email', resp['user']['email'].toString());
            prefs.setString('phone_number', resp['user']['phone_number'].toString());
            prefs.setString('mobile', resp['user']['mobile'].toString());
            prefs.setString('dob', resp['user']['dob'].toString());
            prefs.setString('gender', resp['user']['gender'].toString());
            prefs.setString('blood_type', resp['user']['blood_type'].toString());
            prefs.setString(
                'marital_status', resp['user']['marital_status'].toString());
            prefs.setString('occupation', resp['user']['occupation'].toString());
            prefs.setString(
                'linkedin_username', resp['user']['linkedin_username'].toString());
            prefs.setString('linkedin_url', resp['user']['linkedin_url'].toString());
            prefs.setString('country', resp['user']['country'].toString());
            prefs.setString('city', resp['user']['city'].toString());
            prefs.setString('state', resp['user']['state'].toString());
            prefs.setString('zip_code', res

            p['user']['zip_code'].toString());
            prefs.setString('photo_url', resp['user']['photo_url'].toString());

            prefs.setBool('isUserLoggedIn', isRememberMeTextBoxChecked);


            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));




        } else {
            Toast.show(resp['message'].toString(), context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }

        */
  }

  void getSavedValuesFromSharedPreference() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      photo_url = prefs.getString("photo_url").toString();
      name = prefs.getString("name").toString();
      email = prefs.getString("email").toString();
    });

    //  photo_url = "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  }

  void setLogOutStateInSharedPreference() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserLoggedIn', false);
  }

  Widget getAppBarWidget(String title) {
    return AppBar(
      title: Center(
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xFF573555),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        )
      ],
    );
  }

  Widget getBottomNavigationBarWdiget() {
    return Container(
      height: 20.0,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget getDrawerWidget() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xFF81687f)),
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF573555),
              ),
              accountName: Text(
                "" + name + "",
                style: TextStyle(
                    color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                email,
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.red,
                backgroundImage: NetworkImage(photo_url),
              ),
            ),
            ListTile(
                title: Text(
                  'Edit Profile',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfilePage()));
                }),
            ListTile(
                title: Text(
                  'Terms and Conditions',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () {}),
            ListTile(
                title: Text(
                  'Manage Notifications',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () {}),
            ListTile(
                title: Text(
                  'About',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () {}),
            ListTile(
                title: Text(
                  'Contact Us',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
                onTap: () {}),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              onTap: () {
                setLogOutStateInSharedPreference();

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getTabBarWidget(double height, double width) {
    return Container(
      //  color: Colors.pink,
      height: height * 0.50,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 0),
      //   padding: EdgeInsets.only(top: 20),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text("ALL", style: TextStyle(fontSize: width * 0.035),),
                    ),
                    Tab(
                      child: Text("MUNCIPALITY", style: TextStyle(fontSize: width * 0.035 ),),
                    ),
                    Tab(
                      child: Text("COMMUNITY", style: TextStyle(fontSize: width*0.035),),
                    ),
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(50.0)),
          body: TabBarView(
            children: [
              getListViewWidget(height, width, allNewsData),
              getListViewWidget(height, width, municipalityNewsData),
              getListViewWidget(height, width, communityNewsData),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCarouselWidget(double height) {
     return  Expanded(
      flex:2,
      child: SizedBox.expand(
        child: FutureBuilder(
          future: HttpHelper.makeNewsGalleryImagesRequest(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            networkImagesList.clear();

            for(var loop = 0;loop < snapshot.data['news'].length; loop++){
              networkImagesList.add(NetworkImage(snapshot.data['news'][loop]));
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
    );
  }

  Widget getListViewWidget(double height, double width, var dataArray) {
    return ListView.builder(
      itemCount: dataArray == null ? 0 : dataArray.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {

           /*   var deepLink;

              if(index == 0){
                   deepLink = "https://www.bbc.com/news/election-us-2020-54574584";

                  dataArray[index]["images"] = [
                      {
                          "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/3715/production/_115010141_gettyimages-1228948146.jpg"
                      },{
                            "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/16BAD/production/_115010139_gettyimages-593350990.jpg"
                      },{
                            "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/11D8D/production/_115010137_gettyimages-525613820.jpg"
                      }
                  ];
              }else if(index == 1){
                   deepLink = "https://www.bbc.com/news/world-europe-54684753";
                  dataArray[index]["images"] = [
                      {
                          "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/13F0C/production/_115067618_hi064015166.jpg"
                      },{
                        "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/44A8/production/_115067571_hi064015445.jpg"
                      }
                  ];
              }else{
                  deepLink = "https://www.bbc.com/news/world-europe-54682222";

                      dataArray[index]["images"] = [
                              {
                                  "url": "https://ichef.bbci.co.uk/news/800/cpsprodpb/69B0/production/_115065072_hi062676451.jpg"
                              },{
                                  'url': "https://ichef.bbci.co.uk/news/800/cpsprodpb/114AA/production/_115062807_mediaitem115062806.jpg"
                              }
                          ];
              }
*/

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsPage(
                    title: dataArray[index]["title"],
                    description: dataArray[index]["description"],
                    deepLink: dataArray[index]["deep_link"],
                    images: dataArray[index]["images"]
                ),),
            );
          },
          child: ListViewTileWidget(
              height: height ,
              width: width,
              dataArray: dataArray,
              index: index,
          )


            /* Expanded(
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    height: height / 9,
                    width: width / 4,
                    child: Image(
                      image: NetworkImage(dataArray[index]["thumbnail"]),
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
                            dataArray[index]["description"],

                            style: TextStyle(fontWeight: FontWeight.bold),

                            //overflow: TextOverflow.clip,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, left: width * 0.40),
                          child: Text(
                            Jiffy(dataArray[index]["created_at"]).fromNow(),

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
          ),*/

        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,

        appBar: CustomAppBar(

          title: "News",
          width: width,
          height: height,
        ),

        // CustomAppBar(title: "News"),

        //getAppBarWidget('News'),

        drawer: getDrawerWidget(),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[



                getCarouselWidget(height),
                getTabBarWidget(height, width),
              ],
            )
          ],
        ));
  }
}
