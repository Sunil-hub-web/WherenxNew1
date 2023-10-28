
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';
import 'package:wherenxnew1/modelclass/ShowAllPinResponse.dart';

class ShowAllPin {

  Future<http.Response> showPinDetails(String userId) async {

    http.Response response;

        response = await http.post(
        Uri.parse(ApiUrl.show_all_pin),
            headers: <String, String> {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{'user_id': userId}));

    return response;

    // if (response.statusCode == 200) {
    //   List<ShowAllPinResponse> model = pinresponse.map((dynamic item) => ShowAllPinResponse.fromJson(item),).toList();
    //   return response;
    // }
  }
}