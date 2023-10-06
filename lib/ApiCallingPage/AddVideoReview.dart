import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class AddVideoView{

  Future<http.StreamedResponse?> addVideoReviewDetails(String user_id,String review_date, String reviewer_name,
      String restaurant_name, String place_id, String rating, video) async {

    http.StreamedResponse? response;

    // response = await http.post(Uri.parse(ApiUrl.upload_video_review),
    //
    //     headers: <String,String>{ 'Content-Type': 'application/json; charset=UTF-8',},
    //
    //     body: jsonEncode(<String,String>{
    //       'user_id' : user_id,
    //       'review_date' : review_date,
    //       'reviewer_name' : reviewer_name,
    //       'restaurant_name' : restaurant_name,
    //       'place_id' : place_id,
    //       'rating' : rating,
    //       'video' : video}));

    try{

      var request = http.MultipartRequest('POST', Uri.parse(ApiUrl.upload_video_review));
      request.fields.addAll({'user_id' : user_id,
            'review_date' : review_date,
            'reviewer_name' : reviewer_name,
            'restaurant_name' : restaurant_name,
            'place_id' : place_id,
            'rating' : rating,});
      request.files.add(await http.MultipartFile.fromPath('video', video));
     // request.files.add(await http.MultipartFile.fromPath('video', video));
      response = await request.send();
      //response = await request.send();

    }catch(e){

      e.toString();
      print(e);

    }
    return response;

  }
}