import 'dart:convert';
import 'dart:developer';
import '../ApiImplement/ApiUrl.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> loginApi(String userEmail) async {

  http.Response? response;

  try {
    response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'user_email': userEmail}));
  } catch (e) {
    log(e.toString());
  }
  return response;

  // return http.post(
  //   Uri.parse(),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   },
  //   body: jsonEncode(<String, String>{'user_email': user_email}),
  // );
}