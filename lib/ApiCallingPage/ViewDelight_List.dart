import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wherenxnew1/ApiImplement/ApiUrl.dart';
import 'package:wherenxnew1/modelclass/ViewDelightList.dart';

class ViewDelight_List{

  Future<http.Response> getDelightList(String userId) async{

    http.Response response;

    response = await http.post(Uri.parse("https://www.2designnerds.com/wherenx_user/public/api/business/view-user-delights"),

        headers: <String,String>{

          'Content-Type': 'application/json; charset=UTF-8',
        },

        body: jsonEncode(<String,String>{"user_id" : userId}));

    return response;
  }
}