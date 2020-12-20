import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:load/load.dart';
import 'dart:convert';

class Helper{

    //base url
    static String public_url = "https://pitstopsystems.com/iloveae/public/api/";
    //static String public_url = "http://6c75c7692934.ngrok.io/iloveae/public/";

    static String access_token  = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMzQ5NTVkNjRiY2Y5YWRlN2Q5NTRmNGNhYjdkMGQxZDkyN2E3MjNmZGIzZTAwZWMwMTQ1NzUwNzYwMDM5NTQ3YjEyYTBhNTY1ZmE1NmJlN2EiLCJpYXQiOjE2MDgwMjI0OTEsIm5iZiI6MTYwODAyMjQ5MSwiZXhwIjoxNjM5NTU4NDkxLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.a-vYhiaKlgYpkRxyXYVZw1XBjW-QkiJTaCIRbMkyN7qurt_xp5OctNPDb7pYr5_5yFpwsk1mMn5Vy-ctfqCgyP2839MopSH0cybT1MxmzUB_Z6vMK4wull-X6RMUQmaEDRnZ6LrIEAWtM_-Zev2dvSg-eW8HxZCBrP4iVJfovdemFkFSZKEYbHKi0XCuLUwLdrDcOE8uHr_PHrUFSoah4SvXGxkETTrWmJl1oQ2PXC_wte2Ki2Tkt1JS8--KveHxj75u-xYsfpEQQoOeZquf-JiU_1ubQkdTscZ6b891loG2WBEJE2GNiYyamSbFbj83ohEJE9AXat_3yCerPvYB0fBY8yVpQoXqZ3qUmeNtSONy3s4SaVgxu-VVJi6kqm7uu_qjW7f_JXuTEZCVXBZfStKyI3pbCcuWZVajEIBdu_xcOntYxIlYqxBVHjxPOg7-UNwN42JFJp5I_scS5_55y386QG52ME6WixR3W2DtASRJdEjYGuRZhBf-X96pDEu8jET4bJXWHHTQKR5_nF31rWKZjshQ3cE5y7_JbAo_isOtkBTmBy-Q_2HSkdGxsWGv5YQ-uMRwNKSg9fHG__IdDfLx9SLWh15JvrezYHG3l6gaxlg2hjh3sY3QRMxR3iRSz79mk0-OQvdY-kQfYu6_pz3_rlWY6Nijy8hZMao1zTA";


    static  Map headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': access_token
    };

    //end pointsd-
    static String login = public_url+ "login";

    static String register = public_url+ "register";
    static String update = public_url+ "update";
    static String photo_url = public_url+ "photo_url/";

    static String forgot = public_url+ "forgot";
    static String reset = public_url+ "reset";

    static String notify = public_url+ "notification/create";

    static String show_news = public_url+ "news/show";


    static String category_business_listing = public_url+ "job/show";
    static String searched_business_listing = public_url+ "job/showBySearch";


    static String show_success_stories = public_url+ "success_story/show";

    static String category_tourism_activities_listing = public_url+ "tourism/article/search_by_category";
    static String searched_tourism_activities_listing = public_url+ "tourism/article/search_by_keyword";

    static String show_events = public_url+ "event/show";




    static getUploadDurationTime(String created_at_date){
        return Jiffy(created_at_date).fromNow();
    }




    static openPhoneDialler(String numberString){
        // eg; numberString: 03472548955
        numberString = numberString.substring(7, numberString.length);  //output gives 03472548955
        launch("tel://"+numberString);
    }


    static openMailer(String emailString){
        // eg;  Email: amir@outlook.com
        emailString = emailString.substring(7, emailString.length);  //output gives amir@outlook.com
        launch('mailto:'+ emailString);
    }


    static String timeDifferenceCalculator(String date){
        print('in time difference calculator');
        print(date);

        var arr = date.split('-');


        final birthday = DateTime(int.parse(arr[0]),int.parse(arr[1]),int.parse(arr[2]));
        final date2 = DateTime.now();
        final difference = birthday.difference(date2).inDays;

        return difference.toString();
    }







}

