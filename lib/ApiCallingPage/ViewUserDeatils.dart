
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class ViewUserDetails{

  Future<http.Response?> getUserDetails(String userId) async{
    
    http.Response response;

    try{

      response = await http.post( Uri.parse(ApiUrl.view_user_details),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body : jsonEncode(<String,String>{"user_id" : userId}));

      return response;

    }catch(e){

      e.toString();
    }
    
   return null;

  }

}