import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';

class JobResultPage extends StatefulWidget {
  String name;
  String category;
  String designation;
  String contact_details;
  String email;
  String linkedin_url;
  String photo_url;
  List jobsData;

  JobResultPage({Key key, this.jobsData, this.category}) : super(key: key);

  @override
  _JobResultPageState createState() =>
      _JobResultPageState(this.jobsData, this.category);
}

class _JobResultPageState extends State<JobResultPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String name;
  String category;
  String designation;
  String contact_details;
  String email;
  String linkedin_url;
  String photo_url;
  List jobsData;

  _JobResultPageState(this.jobsData, this.category) {
    if (jobsData.length > 0) {
      category = jobsData[0]['category'];
    }
  }

  Widget getRichTextWidget(String key, String value) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          text: key + ": ",
          style: TextStyle(
              fontSize: 12.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getListViewWidget(double height, double width) {
    return (jobsData.length == 0)
        ? Center(
            child: Text(
            'No records found.',
            style: TextStyle(fontSize: 25),
          ))
        : ListView.builder(
            itemCount: jobsData == null ? 0 : jobsData.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                children: <Widget>[
                  /*  Padding(

            padding: EdgeInsets.symmetric(horizontal: 19),
            child: Divider(
                thickness: 1.5,


                color: Theme.of(context).primaryColor,
                height: 1.5,


            ),
        ),*/

                   /* Container(
                        width: width * 0.46,
                        child: Divider(
                            thickness: 1.5,
                            color: Colors.black,
                            height: 1.5,
                        ),
                    ),*/
                  Container(
                    width: width * 0.43,
                    child: Divider(
                      thickness: 1.5,
                      color: Theme.of(context).primaryColor,
                      height: 1.5,
                    ),
                  ),
                  Container(
                    color: Theme.of(context).backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          height: 75,
                          width: 75,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(jobsData[index]["photo_url"]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 7),
                                getRichTextWidget(
                                    "Name", jobsData[index]["name"]),
                                getRichTextWidget("Occupation",
                                    jobsData[index]["designation"]),
                                GestureDetector(
                                  child: getRichTextWidget("Contact Details",
                                      jobsData[index]["contact_details"]),
                                  onTap: () {
                                    Helper.openPhoneDialler(
                                        jobsData[index]["contact_details"]);
                                  },
                                ),
                                GestureDetector(
                                  child: getRichTextWidget(
                                      "Email", jobsData[index]["email"]),
                                  onTap: () {
                                    Helper.openMailer(jobsData[index]["email"]);
                                  },
                                ),
                                getRichTextWidget("LinkedIn",
                                    jobsData[index]["linkedin_url"]),
                                SizedBox(height: 7),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                    Container(
                        width: width * 0.43,
                        child: Divider(
                            thickness: 1.5,
                            color: Theme.of(context).primaryColor,
                            height: 1.5,
                        ),
                    ),
                ],
              ));
            },
          );
  }

  Widget getHeaderWidget(double height) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: height * 0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/email_icon.png",
            width: 50,
            height: 50,
          ),
          SizedBox(
            width: 30,
          ),
          Padding(
            padding: EdgeInsets.only(right: 85),
            child: Text(
              this.category,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
        title: 'Business Directory',
        height: height,
        width: width / 11,
      ),
      bottomNavigationBar: new Container(
        height: 20.0,
        color: Color(0xFF573555),
      ),
      body: Column(
        children: <Widget>[
          getHeaderWidget(height),
          Container(
            height: height * 0.70,
            color: Theme.of(context).backgroundColor,
            child: getListViewWidget(height, width),
          ),
        ],
      ),
    );
  }
}
