
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';

class InsertDelightList{

  Future<http.Response> getinsertDelight(String user_id,String delight_id) async{

    http.Response response;

    response = await http.post(Uri.parse(ApiUrl.insert_delights_list),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'user_id': user_id, 'delight_id': delight_id}));

    return response;

  }

}
