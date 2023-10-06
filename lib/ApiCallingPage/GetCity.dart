import 'dart:convert';
import 'dart:developer';

import 'package:wherenxnew1/modelclass/CityResponse.dart';
import 'package:http/http.dart' as http;

import '../ApiImplement/ApiUrl.dart';

class GetCityMethod {

  Future<List<CityResponse>?> getCity(int stateId) async {

    http.Response? response;

    try {
      response = await http.post(
          Uri.parse(ApiUrl.get_cities),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'state_id': stateId}));

      if (response.statusCode == 200) {

        List<CityResponse> model = [];
        model.clear();
        model = userGetStateFromJson(response.body);

        return model;
      }

    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}