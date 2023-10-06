
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class ViewUserProfileImage{

  Future<http.Response> getProfileImage(String UserId) async {

    http.Response response;
    
    response = await http.post(Uri.parse(ApiUrl.view_user_profile_photo),
      
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{'user_id':UserId}));
    
    return response;

  }
}