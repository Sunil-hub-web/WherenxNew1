import 'dart:convert';
import 'dart:developer';
import '../ApiImplement/ApiUrl.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> otpVerifationApi(int user_id,int otp_id, String otp) async {
  http.Response? response;

  try {
    response = await http.post(
        Uri.parse(ApiUrl.login_otp_verification),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'user_id': user_id, 'otp_id': otp_id, 'otp': otp}));
  } catch (e) {
    log(e.toString());
  }
  return response;
}