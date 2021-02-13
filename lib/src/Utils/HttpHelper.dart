import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:load/load.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:flutter_login_signup/src/Utils/SharedPreferenceHelper.dart';
import 'package:flutter_login_signup/src/Utils/FirebaseHelper.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class HttpHelper{




    static Future<Map> makeLoginRequest(email, password) async {
        showLoadingDialog();

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String deviceId = prefs.getString('device_id');



        final http.Response response = await http.post(
            Helper.login,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
            },


            body: jsonEncode(<String, String>{
                'email': email,
                'password': password,
                'device_id':  deviceId,
                'device_type': FirebaseHelper.fetchDeviceType(),
            }),
        );

        hideLoadingDialog();
        return json.decode(response.body);

    }



    static Future<Map> makeBloodNotificationRequest(name, bloodType, hospitalName, contactName, contactNumber) async {
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.notify,
            headers: Helper.headers,

            body: jsonEncode(<String, String>{
                'notification_type': 'blood request',
                'patient_name': name,
                'blood_type': bloodType,
                'hospital_name':  hospitalName,
                'contact_name':  contactName,
                'contact_number': contactNumber,
            }),
        );


        hideLoadingDialog();
        return json.decode(response.body);

    }





    static Future<Map> makeHomeGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_home_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }




    static Future<Map> makeNewsGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_news_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }


    static Future<Map> makeTourismGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_tourism_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }



    static Future<Map> makeSuccessStoriesGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_success_stories_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }



    static Future<Map> makeBloodRequestGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_blood_request_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }





    static Future<Map> makeThingsToDoGalleryImagesRequest() async{
        showLoadingDialog();

        final http.Response response = await http.post(
            Helper.show_tourism_things_to_do_gallery,
            headers: Helper.headers,
        );

        hideLoadingDialog();

        return json.decode(response.body);

    }



}

