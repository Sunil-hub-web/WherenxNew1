
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class AddKMRadius{

  Future<http.Response> addkmRadius(String userId, String radius) async {

    http.Response response;
    response = await http.post(Uri.parse(ApiUrl.add_km_radious),
      headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8',},
      body: jsonEncode(<String,String>{

        'user_id' : userId,
        'radius' : radius,

      })
    );

    return response;

  }
}