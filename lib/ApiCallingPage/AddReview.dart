import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class AddReview{

  Future<http.Response> addReviewDetails(String user_id,String review_date, String reviewer_name,
      String restaurant_name, String place_id, String rating, String message) async {

    http.Response response;

    response = await http.post(Uri.parse(ApiUrl.add_review),

      headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8',},

      body: jsonEncode(<String,String>{
        'user_id' : user_id,
        'review_date' : review_date,
        'reviewer_name' : reviewer_name,
        'restaurant_name' : restaurant_name,
        'place_id' : place_id,
        'rating' : rating,
        'message' : message}));

    return response;

  }
}