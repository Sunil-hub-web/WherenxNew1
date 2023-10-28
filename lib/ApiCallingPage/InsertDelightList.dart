
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class InsertDelightList{

  Future<http.Response> getinsertDelight(String userId,String delightId) async{

    http.Response response;

    response = await http.post(Uri.parse(ApiUrl.insert_delights_list),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'user_id': userId, 'delight_id': delightId}));

    return response;

  }

}
