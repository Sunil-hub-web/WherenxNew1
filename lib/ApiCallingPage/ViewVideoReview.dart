
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class ViewVideoReview{

  Future<http.Response?> viewVideoReview(String user_id, String place_id) async {

    http.Response? response;

    try{

    //  http.Response response;

      response = await http.post(Uri.parse(ApiUrl.view_user_video_reviews),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String,String>{
            'user_id': user_id,
            'place_id': place_id
          })
      );

    }catch(e){
      print("errormessage${e.toString()}");
    }

   return response;

  }
}