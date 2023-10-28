
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class ShowNearByLocation {

  Future<http.Response> showNearByPin(String userId, String latitude, String longitude, String radius) async {

    http.Response response;
    response = await http.post(Uri.parse(ApiUrl.near_by_pin_location),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
       body: jsonEncode(<String, String>{
         'user_id' : userId,
         'latitude' : latitude,
         'longitude' : longitude,
         'radius' : radius,
       }));

       return response;

    }

  }