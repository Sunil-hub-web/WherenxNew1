import 'dart:convert';
import 'dart:developer';

import 'package:wherenxnew1/modelclass/StateResponse.dart';
import 'package:http/http.dart' as http;

import '../ApiImplement/ApiUrl.dart';


class GetState {
  Future<List<StateResponse>?> getState(int stateId) async {

    http.Response? response;

    try {
      response = await http.post(
          Uri.parse(ApiUrl.get_states),
          headers: <String, String> {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{'country_id': stateId}));

      if (response.statusCode == 200) {

        List<StateResponse> model = [];
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