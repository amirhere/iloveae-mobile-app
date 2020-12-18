import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Utils/FirebaseHelper.dart';

class SharedPreferenceHelper {
  static bool isDeviceTokenAvailable;


  static saveDataToSharedPreference(resp, isRememberMeTextBoxChecked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', resp['token'].toString());

    prefs.setString('user_id', resp['user']['id'].toString());

    prefs.setString('name', resp['user']['name'].toString());
    prefs.setString('nick_name', resp['user']['nick_name'].toString());
    prefs.setString('family_name', resp['user']['family_name'].toString());
    prefs.setString('father_name', resp['user']['father_name'].toString());
    prefs.setString('mother_name', resp['user']['mother_name'].toString());

    prefs.setString('dob', resp['user']['dob'].toString());
    prefs.setString('gender', resp['user']['gender'].toString());
    prefs.setString('blood_type', resp['user']['blood_type'].toString());
    prefs.setString('occupation', resp['user']['occupation'].toString());
    prefs.setString(
        'second_occupation', resp['user']['second_occupation'].toString());
    prefs.setString(
        'marital_status', resp['user']['marital_status'].toString());
    prefs.setString('country', resp['user']['country'].toString());
    prefs.setString('city', resp['user']['city'].toString());
    prefs.setString('street', resp['user']['street'].toString());

    prefs.setString(
        'mobile_country_code', resp['user']['mobile_country_code'].toString());
    prefs.setString('mobile', resp['user']['mobile'].toString());

    prefs.setString(
        'phone_country_code', resp['user']['phone_country_code'].toString());
    prefs.setString('phone', resp['user']['phone'].toString());

    prefs.setString('email', resp['user']['email'].toString());
    prefs.setString('linkedin_url', resp['user']['linkedin_url'].toString());

    prefs.setString('photo_url', resp['user']['photo_url'].toString());

    prefs.setBool('isUserLoggedIn', isRememberMeTextBoxChecked);
  }




  static Future setDeviceIdInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!(prefs.containsKey('device_id'))) {
      await FirebaseHelper.fetchDeviceTokenFromFB().then((token) {
        prefs.setString('device_id', token);
        FirebaseHelper.device_token = prefs.getString('device_id');
      });
    }

  }
}
