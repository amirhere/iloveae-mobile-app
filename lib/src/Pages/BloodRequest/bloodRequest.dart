import 'package:flutter/material.dart';
import 'dart:math';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Widgets/customBottomNavigationBar.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Pages/BusinessDirectory/jobResultPage.dart';
import 'package:toast/toast.dart';
import 'package:flutter_login_signup/src/Widgets/carouselWidget.dart';
import 'package:flutter_login_signup/src/Widgets/buttonWidget.dart';
import 'package:flutter_login_signup/src/Utils/HttpHelper.dart';
import 'package:flutter_login_signup/src/Pages/homePage.dart';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:form_field_validator/form_field_validator.dart';


import 'package:load/load.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_signup/src/Pages/Notification/notificationPage.dart';


class BloodRequestPage extends StatefulWidget {
  BloodRequestPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BloodRequestPageState createState() => _BloodRequestPageState();
}

class _BloodRequestPageState extends State<BloodRequestPage> {

  final _formKey = GlobalKey<FormState>();
  String _bloodTypeDropDownValue = 'Blood Type *';
  var _bloodTypeDropDownListItem = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];




  TextEditingController nameTextEditingController =  new TextEditingController();
  TextEditingController hospitalNameTextEditingController = TextEditingController();
  TextEditingController contactNameTextEditingController = TextEditingController();
  TextEditingController contactNumberTextEditingController = TextEditingController();



  @override
  void initState() {



  }

  Widget getBloodTypeWidget(double width) {
    //double width = MediaQuery.of(context).size.width;

    return new Stack(
      children: <Widget>[
        Container(
          //  color:Colors.green,
          // width: width * 0.30,
          //    color: Colors.blue,F
          padding: EdgeInsets.only(left: 0.0),
          margin: EdgeInsets.only(
            left: width * 0.12,
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
                onTap: () {
                  setState(() {
                    //  bloodTypeColor = _bloodTypeColors[0];
                  });
                },
                hint: _bloodTypeDropDownValue == null
                    ? Text('Dropdown')
                    : Text(
                  _bloodTypeDropDownValue,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(
                    color: Color(0xFF573555),
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
                items: _bloodTypeDropDownListItem.map(
                      (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                        () {
                      _bloodTypeDropDownValue = val;
                    },
                  );
                },
              )),
        ),
        Container(
          //color: Colors.red,
          width: width * 0.12,

          child: IconButton(
            icon: new Image.asset(
              'assets/blood_request/icons/blood_type.png',
              width: 25,
              height: 25,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }

  Widget getNameTextFieldWidget() {
    return new TextFormField(
        validator: MinLengthValidator(4, errorText: 'Minimum 4 characters allowed') ,
        controller: nameTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Patient Name *',
          labelStyle: TextStyle(
            // color: nameColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/blood_request/icons/patient_name.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getHospitalNameTextFieldWidget() {
    return new TextFormField(
        validator: MinLengthValidator(4, errorText: 'Minimum 4 characters allowed') ,
        controller: hospitalNameTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Hospital Name *',
          labelStyle: TextStyle(
            //color: nameColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/blood_request/icons/hospital_name.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getContactNameTextFieldWidget() {
    return new TextFormField(
        validator: MinLengthValidator(4, errorText: 'Minimum 4 characters allowed') ,
        controller: contactNameTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Contact Name *',
          labelStyle: TextStyle(
            //color: nameColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/blood_request/icons/contact_person.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getContactNumberTextFieldWidget() {
    return new TextFormField(
        validator: MinLengthValidator(7, errorText: 'Enter valid contact number ') ,

        controller: contactNumberTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Contact Number *',
          labelStyle: TextStyle(
            //color: nameColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/blood_request/icons/contact_number.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFdde9f2)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFdde9f2)),
          ),
        ));
  }




  Widget getBloodRequestFormWidget(height, width) {
    return Container(
        color: Color(0xFFdde9f2),
        margin: EdgeInsets.symmetric(horizontal: width * 0.14),
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              getNameTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getBloodTypeWidget(width),
              Divider(
                height: 1,
                color: Theme.of(context).primaryColor,
                thickness: 1,
              ),
              // getFatherNameTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getHospitalNameTextFieldWidget(),

              SizedBox(
                height: 10,
              ),
              getContactNameTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getContactNumberTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  Widget getCarouselWidget(double height) {
    return Container(
      height: height * (1 / 3),
      child: Center(
          child: Image.asset('assets/blood_request/banners/blood_banner')


        /* SizedBox.expand(
          child: Carousel(
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Color(0xFF573555),
            indicatorBgPadding: 5.0,
            //  dotBgColor: Colors.purple.withOpacity(0.5),
            //borderRadius: true,
            images: [
              //  ExactAssetImage("assets/banner1.png"),
              //   ExactAssetImage("assets/banner2.png"),
              //  ExactAssetImage("assets/banner1.png"),
              NetworkImage(
                  'https://emiratesca.com/contents/uploads/media/banner.png'),
            ],
          ),
        ),*/
      ),
    );
  }




  makeBloodRequestHttpRequest(name, bloodType, hospitalName, contactName, contactNumber) async{
    await HttpHelper.makeBloodNotificationRequest(name, bloodType, hospitalName, contactName, contactNumber).then((resp){
      if (resp['status'].toString() == "true") {

        Toast.show("Request Initiated Successfully", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pop();
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
    //  resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: CustomAppBar(
        title: 'Blood Request',
        height: height,
        width: width * 0.20,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: height,
      ),
      body: Column(
        children: [
          // getCarouselWidget(height),

         Expanded(
           flex: 1,
           child:  Image.asset('assets/blood_request/banners/blood_banner.png'),
         ),

         Expanded(
           flex: 2,
           child:  Container(
             child: SingleChildScrollView(

               child: Column(
                 children: <Widget>[

                   SizedBox(height: height * 0.09),
                   getBloodRequestFormWidget(height, width),
                   SizedBox(height: height * 0.03),


                   GestureDetector(
                     onTap: () {
                       if (_formKey.currentState.validate()) {

                         makeBloodRequestHttpRequest(nameTextEditingController.text, _bloodTypeDropDownValue, hospitalNameTextEditingController.text, contactNameTextEditingController.text, contactNumberTextEditingController.text);
                       }
                     },
                     child: ButtonWidget(label: 'Submit'),
                   ),
                   SizedBox(height: height * 0.03),
                 ],
               ),
             ),
           ),
         ),
        ],
      ),

    );
  }
}