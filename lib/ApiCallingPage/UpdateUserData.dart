import 'dart:convert';
import 'dart:developer';

import '../ApiImplement/ApiUrl.dart';
import 'package:http/http.dart' as http;

class UpdateUserData{

 Future<http.Response?> updateuserDet(String userId,String fullname,String email,String country,String state,String city) async {

   http.Response? response;

   try {
     response = await http.post(
         Uri.parse(ApiUrl.update_user_details),

         headers: <String, String>{
           'Content-Type': 'application/json; charset=UTF-8',
         },

         body: jsonEncode(<String, String>{
           'user_id':userId,
           'user_full_name': fullname,
           'user_email': email,
           'user_country': country,
           'user_state': state,
           'user_city': city,
         }));

   } catch (e) {
     log(e.toString());
   }
   return response;
 }
}