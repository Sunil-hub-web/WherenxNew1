import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/modelclass/DelightsResponse.dart';
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';


class DelightList {

  Future<List<DelightsResponse>?> getDelight() async {
    http.Response? response;
    try {
      var url = Uri.parse(ApiUrl.get_delights);
      response = await http.get(url);
      List<dynamic> body = jsonDecode(response.body);
      //  return response;
      if (response.statusCode == 200) {
        List<DelightsResponse> model = body.map((dynamic item) => DelightsResponse.fromJson(item),).toList();
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

