import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'registration.dart';

import 'package:flutter_login_signup/src/Utils/Helper.dart';




class ForgotPasswordPage extends StatefulWidget {
    ForgotPasswordPage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}


class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

    bool isEmailTextFieldVisible = true;
    bool isNewPasswordTextFieldsVisible = false;
    bool isConfirmPasswordTextFieldsVisible = false;
    bool isVerificationCodeTextFieldVisible = false;
    String  passwordResetToken = '';
    int submitBtnHttpRequestTracker = 0;

    var showVerificationCodeTextField;
    var showEmailTextField;
    var showPasswordTextField;
    var showConfirmPasswordTextField;

    Widget _submitButton() {
        return GestureDetector(
            onTap: (){

                if(submitBtnHttpRequestTracker == 0) {

                    if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailTextEditingController.text))
                        makeForgotPasswordRequest();
                    else
                        Toast.show('Invalid Email', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);




                }else{

                    if((passwordTextEditingController.text == confirmPasswordTextEditingController.text)){
                        if(passwordResetToken  == verificationCodeTextEditingController.text){
                            makeResetPasswordRequest();
                        }else{
                            Toast.show('Invalid Token', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                        }

                    }else{
                        Toast.show('Passwords do not match', context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

                    }
                }

            },

            child: new Container(
                color: Color(0xff84849d),
               // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
               // color: Color(0xFFdde9f2),
                alignment: Alignment.center,

                child: RichText(
                    text: new  TextSpan(
                        text: 'SUBMIT',
                        style: new TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF573555),
                        ),
                    ),
                ),
            )
        );
    }

    Widget _divider() {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
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
                            ),
                        ),
                    ),
                    Text('or'),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                                thickness: 1,
                            ),
                        ),
                    ),
                    SizedBox(
                        width: 20,
                    ),
                ],
            ),
        );
    }

    Widget _createAccountLabel() {
        return InkWell(
            onTap: () {

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AccountPage()));
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(15),
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            'Don\'t have an account ?',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                            width: 10,
                        ),
                        Text(
                            'Register',
                            style: TextStyle(
                                color: Color(0xFF573555),
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                        ),
                    ],
                ),
            ),
        );
    }



    TextEditingController passwordTextEditingController = new TextEditingController();

    TextEditingController confirmPasswordTextEditingController = new TextEditingController();

    TextEditingController emailTextEditingController = new TextEditingController();

    TextEditingController verificationCodeTextEditingController = new TextEditingController();


    Widget _emailPasswordWidget() {
        return Container(
            color: Color(0xFFdde9f2),
            margin: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 30
        ),
            child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 30
                ),
                child: Column(
                    children: <Widget>[

                        SizedBox(height:10),
                        (isEmailTextFieldVisible) ? showEmailTextField : //
                        SizedBox(height:10),
                        (isVerificationCodeTextFieldVisible)? showVerificationCodeTextField:// ,
                        SizedBox(height:10),
                        (isNewPasswordTextFieldsVisible) ? showPasswordTextField : //
                        SizedBox(height:10),
                        (isConfirmPasswordTextFieldsVisible) ? showConfirmPasswordTextField: //
                        SizedBox(height:30),

                    ],
                ),
            ),
        );
    }

    var showProgressBar  = Visibility(
        child: Image(
            image: AssetImage('assets/progressBar.gif'),
            width: 50,
            height: 50
        ),
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: true,
    );




    void makeForgotPasswordRequest () async {

        final http.Response response = await http.post(
            Helper.forgot,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
                'email': emailTextEditingController.text,
              //  'password': passwordTextEditingController.text
            }),
        );

        print(response.body);

        Map resp = json.decode(response.body);
        if(resp['status'].toString() == "true"){

            passwordResetToken = resp['password_reset_token'].toString();
            submitBtnHttpRequestTracker++;


            setState(() {
                isEmailTextFieldVisible = false;

                isNewPasswordTextFieldsVisible = true;
                isConfirmPasswordTextFieldsVisible = true;
                isVerificationCodeTextFieldVisible = true;

            });

            Toast.show(resp['message'].toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        }else{
            Toast.show(resp['message'].toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        }




    }

    void makeResetPasswordRequest () async {

        final http.Response response = await http.post(

            Helper.reset,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
                'token': verificationCodeTextEditingController.text,
                'password': passwordTextEditingController.text,
                'email': emailTextEditingController.text,
                //  'password': passwordTextEditingController.text
            }),
        );

        print(response.body);

        Map resp = json.decode(response.body);
        if(resp['status'].toString() == "true"){
            Navigator.pop(context, false);

            Toast.show("Password Updated Successfully!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        }else{
            Toast.show(resp['message'].toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

        }

   }

    @override
    void initState() {

            showVerificationCodeTextField = Visibility(
            child: TextField(
                controller: verificationCodeTextEditingController,
                obscureText: false,
                keyboardType: TextInputType.text,
                cursorColor: Color(0xFF573555),
                decoration: InputDecoration(
                    labelText: 'Verification Code',
                    labelStyle: TextStyle(
                        color: Color(0xFF573555)
                    ),

                    prefixIcon: Icon(Icons.verified_user, color: Color(0xFF573555),),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),

                ),
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
        );

           showEmailTextField = Visibility(
            child: TextField(
                controller: emailTextEditingController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color(0xFF573555),
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Color(0xFF573555)
                    ),

                    prefixIcon:  new IconButton(
                        icon: new Image.asset(
                            'assets/email_icon.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                        onPressed: null,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),
                ),
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
        );

           showPasswordTextField = Visibility(
            child: TextField(
                controller: passwordTextEditingController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: Color(0xFF573555),
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color(0xFF573555)
                    ),

                    prefixIcon: IconButton(
                        icon: new Image.asset(
                            'assets/password_icon.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                        onPressed: null,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF000000))),

                ),
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
        );

            showConfirmPasswordTextField = Visibility(
            child: TextField(
                controller: confirmPasswordTextEditingController,
                obscureText: true,
                keyboardType: TextInputType.text,
                cursorColor: Color(0xFF573555),
                decoration: InputDecoration(
                    labelText: 'Confim Password',
                    labelStyle: TextStyle(
                        color: Color(0xFF573555)
                    ),

                    prefixIcon: IconButton(
                        icon: new Image.asset(
                            'assets/confirm_password_icon.png',
                            width: 25.0,
                            height: 25.0,
                        ),
                        onPressed: null,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFdde9f2))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFdde9f2))),

                ),
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: true,
        );


    }






    @override
    Widget build(BuildContext context) {
        final height = MediaQuery.of(context).size.height-200;
        return Scaffold(
            backgroundColor: Color(0xffc7dceb),

            bottomNavigationBar: new Container(
                height: 20.0,
                color: Color(0xFF573555),
            ),
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xFF573555),
                title: const Text('Reset Password',  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                fontSize: 15
            ),),
                leading: IconButton (
                    icon:Icon(Icons.arrow_back_ios),
                    color: Color(0xFFFFFFFF),
                    onPressed: () => Navigator.pop(context, false),


                ),
            ),
            body: Container(
                height: height,
                child: Stack(
                    children: <Widget>[

                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        SizedBox(height: 110),
                                        // _title(),
                                        //  SizedBox(height: 30),
                                        _emailPasswordWidget(),
                                        SizedBox(height: 45),
                                        _submitButton(),


                                        // _facebookButton(),
                                        SizedBox(height: 10),

                                    ],
                                ),
                            ),
                        ),
                        // Positioned(top: 40, left: 0, child: _backButton()),
                    ],
                ),
            ),
        );
    }

}
