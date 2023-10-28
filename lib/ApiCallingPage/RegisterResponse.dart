import 'dart:convert';
import 'dart:developer';

import '../ApiImplement/ApiUrl.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> userRegister_det(String fullname,String email,String country,String state,String city) async {
  http.Response? response;

  try {
    response = await http.post(
        Uri.parse(ApiUrl.user_register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
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
