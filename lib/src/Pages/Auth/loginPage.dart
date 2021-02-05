import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registration.dart';
import 'package:flutter_login_signup/src/Pages/Auth/forgotPasswordPage.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Pages/homePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_signup/src/Utils/FirebaseHelper.dart';
import 'package:flutter_login_signup/src/Utils/SharedPreferenceHelper.dart';
import 'package:flutter_login_signup/src/Utils/HttpHelper.dart';
import 'package:load/load.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProgressBarVisible = false;
  bool isRememberMeTextBoxChecked = false;

  @override
  void initState() {

      SharedPreferenceHelper.setDeviceIdInSharedPreference();

  }

  Widget _submitButtonWidget() {
    return GestureDetector(
      onTap: () {

          FocusScope.of(context).unfocus();  //hides keyboard so that toast messages can be seen.



          if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(userNameTextEditingController.text)) {
          if (passwordTextEditingController.text.length >= 8) {
            makeLoginRequest();
          } else {
            Toast.show(
                "Password length should be atleast 8 characters", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("Invalid email address", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
      child: new Container(
          color: Color(0xff84849d),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,

        child: RichText(
          text: new TextSpan(
            text: 'LOGIN',
            style: new TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF573555),
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordWidget() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: Stack(
                children: <Widget>[
                  // Checkbox(value: 'alifbss', onChanged: null)

                  CheckboxListTile(
                    // dense: true,
                    title: RichText(
                      text: new TextSpan(
                        text: '',
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff84849d),
                        ),
                      ),
                    ),
                    value: isRememberMeTextBoxChecked,
                    onChanged: (newValue) {
                      setState(() {
                        isRememberMeTextBoxChecked =
                            !isRememberMeTextBoxChecked;
                      });
                    },

                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),

                  Container(
                    // color: Colors.red,
                    margin: EdgeInsets.only(left: 40, top: 18),
                    child: Text(
                      "Remember Me",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff84849d),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Text('or'),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: new TextSpan(
                      text: 'Forgot Password?',
                      style: new TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff84849d),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Color(0xFF84849d),
                ),
              ),
            ),
            //  Text('or'),
            /* Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),  */
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountPage()));
        },
        child: new Container(
            color: Color(0xff84849d),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,

          child: RichText(
            text: new TextSpan(
              text: 'CREATE AN ACCOUNT',
              style: new TextStyle(
                fontWeight: FontWeight.w900,
                color: Color(0xFF573555),
              ),
            ),
          ),
        ));
  }

  TextEditingController userNameTextEditingController =
      new TextEditingController();

  TextEditingController passwordTextEditingController =
      new TextEditingController();

  Widget _emailPasswordWidget() {
    return Container(
      color: Color(0xFFdde9f2),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          TextField(
            controller: userNameTextEditingController,
            keyboardType: TextInputType.text,
            cursorColor: Color(0xFF573555),
            decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                labelStyle: TextStyle(
                    color: Color(0xFF573555), fontWeight: FontWeight.w600),
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'assets/email_icon.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  onPressed: null,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFdde9f2))),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdde9f2)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: passwordTextEditingController,
            obscureText: true,
            keyboardType: TextInputType.text,
            cursorColor: Color(0xFF573555),
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Color(0xFF573555), fontWeight: FontWeight.w600),
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'assets/password_icon.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  onPressed: null,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdde9f2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFdde9f2)),
                )),
          )
        ],
      ),
    );
  }



  void makeLoginRequest() async {
    await HttpHelper.makeLoginRequest(userNameTextEditingController.text,
            passwordTextEditingController.text)
        .then((resp) {
      if (resp['status'].toString() == "true") {


        SharedPreferenceHelper.saveDataToSharedPreference(
            resp, isRememberMeTextBoxChecked);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Toast.show(resp['message'].toString(), context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: CustomBottomNavigationBar(height: height / 28),
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title:  Center(
              child: Text(
                  'Login',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15
                  ),
              ),
          ),




      ),
      body: new GestureDetector(
        onTap: ()=> FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 50),
              _emailPasswordWidget(),
              SizedBox(height: 20),

              _submitButtonWidget(),
              _forgotPasswordWidget(),
              _dividerWidget(),
              // _facebookButton(),
              SizedBox(height: 10),
              _createAccountLabel(),
            ],
          ),
        ),

      ),
    );
  }
}
