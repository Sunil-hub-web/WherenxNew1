
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class ViewReviewList{

  Future<http.Response> getReviewList(String userId, String placeId) async {

    http.Response response;
    response = await http.post(Uri.parse(ApiUrl.view_user_reviews),
    headers: <String,String>{'Content-Type': 'application/json; charset=UTF-8',},
    body: jsonEncode(<String,String>{'user_id' : userId, 'place_id' : placeId}));

    return response;


  }
}