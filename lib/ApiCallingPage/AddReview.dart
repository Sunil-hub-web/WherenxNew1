import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class AddReview{

  Future<http.Response> addReviewDetails(String userId,String reviewDate, String reviewerName,
      String restaurantName, String placeId, String rating, String message) async {

    http.Response response;

    response = await http.post(Uri.parse(ApiUrl.add_review),

      headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8',},

      body: jsonEncode(<String,String>{
        'user_id' : userId,
        'review_date' : reviewDate,
        'reviewer_name' : reviewerName,
        'restaurant_name' : restaurantName,
        'place_id' : placeId,
        'rating' : rating,
        'message' : message}));

    return response;

  }
}