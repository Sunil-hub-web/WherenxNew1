import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class PinPlaces{

  Future<http.Response> insertPinPlaces(String userId, String delightId, delightName, String placeId, String latitude, String longitude,
      String name, String website, String address, String city,String state,String zip,String phonenumber, String description, 
      String opentime, String closetime, String openfromto, String photolink, String rating, String commentsrating) async{
    
    http.Response response;
    
    response = await http.post(Uri.parse(ApiUrl.pinThisBusiness),

      headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8',},


      body: jsonEncode(<String,String>{ "user_id":userId, "delight_id":delightId, "delight_name": delightName, "place_id": placeId, "latitude": latitude,
        "longitude": longitude, "name": name, "website": website, "address": address, "city": city, "state":state, "zip": zip,
        "phonenumber":phonenumber, "description":description, "opentime":opentime, "closetime":closetime, "openfromto":openfromto,
        "photolink":photolink, "rating":rating, "commentsrating":commentsrating}));

    return response;

  }

}