import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:io';
import 'package:flutter_login_signup/src/Pages/Settings/editProfile.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Widgets/socialMedia.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';


class EventPage extends StatefulWidget {
    String title;
    String description;
    String date;
    String deepLink;
    List images;
    File _image;

    EventPage({this.title, this.description, this.images, this.deepLink, this.date});

    @override
    _EventPageState createState() =>
        _EventPageState(title, description, images, deepLink, date);
}

class _EventPageState extends State<EventPage> {
    String title, description, deepLink,date;
    List images;
    List<NetworkImage> networkImagesList = List<NetworkImage>();
    File _image;
    String _text;

    final ScrollController scrollController = ScrollController();

    _EventPageState(this.title, this.description, this.images, this.deepLink, this.date) {

        for (int loop = 0; loop < images.length; loop++) {
            networkImagesList.add(NetworkImage(images[loop].url));
        }
    }

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SharedPreferences prefs;
    String photo_url;
    String name;
    String email;
    double carouselHeight, contentHeight;

    @override
    void initState() {
        getSavedValuesFromSharedPreference();
        super.initState();

        _text = 'Swipe me!';

        urlToFile('https://pitstopsystems.com/iloveae/logo.png');
    }

    urlToFile(String imageUrl) async {
        var rng = new Random();
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
        http.Response response = await http.get(imageUrl);
        await file.writeAsBytes(response.bodyBytes);

        setState(() {
            _image = file;
        });
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

    void _onVerticalSwipe(SwipeDirection direction) {
        setState(() {
            if (direction == SwipeDirection.up) {
                //_text = 'Swiped up!';
                print('Swiped up!');
            } else {
                // _text = 'Swiped down!';
                print('Swiped down!');
            }
        });
    }

    void _onHorizontalSwipe(SwipeDirection direction) {
        setState(() {
            if (direction == SwipeDirection.left) {
                _text = 'Swiped left!';
                print('Swiped left!');
            } else {
                _text = 'Swiped right!';
                print('Swiped right!');
            }
        });
    }

    void _onLongPress() {
        setState(() {
            _text = 'Long pressed!';
            print('Long pressed!');
        });
    }

    var swiped = false;

    @override
    Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;

        if (swiped == false) {
            carouselHeight = height * (1 / 3);
            contentHeight = height * (1 / 2.7);
        }

        return Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar(
                title: "Event",
                height: height,
                width: width / 3.8,
                // height: 200,
            ),
            bottomNavigationBar: new Container(
                height: 20.0,
                color: Color(0xFF573555),
            ),
            drawer: Theme(
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
            ),
            body: CustomScrollView(
                slivers: <Widget>[

                    SliverAppBar(
                        backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                        expandedHeight: height * (1 / 3),
                        elevation: 0,
                        leading: new Container(),
                        //iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                                tag: 'hero tag',
                                child: Container(
                                    height: height * (1 / 3),
                                    child: Center(
                                        child: SizedBox.expand(
                                            child: Carousel(
                                                dotSize: 4.0,
                                                dotSpacing: 15.0,
                                                dotColor: Color(0xFF573555),
                                                indicatorBgPadding: 5.0,
                                                //  dotBgColor: Colors.purple.withOpacity(0.5),
                                                //borderRadius: true,
                                                images: networkImagesList),
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),

                    SliverToBoxAdapter(
                        child:   Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                        Stack(
                        //  alignment: Alignment.bottomCenter,
                        overflow: Overflow.visible,
                            children: [

                                Positioned(
                                    top: 0,
                                    left:-20,
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
                                                                        date,
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
                                            padding: EdgeInsets.only(top:0),
                                            child:       Container(
                                                height: 75,
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
                                                            "5",
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
                        ),
                                Container(
                                    //height: contentHeight,
                                    width: width,
                                    margin: EdgeInsets.symmetric(horizontal: 30),
                                    padding: EdgeInsets.only(top: 30),
                                    child: Text(
                                        description,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                ),



                                SizedBox(height: 10),
                                SocialMediaWidget(
                                    description: description,
                                   // imagePath: _image.path,
                                    deeplink: deepLink,
                                    height: height),
                                SizedBox(height: 10),

                            ],
                        ),

                    )

                ],
            ));
    }






}
