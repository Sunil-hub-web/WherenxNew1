

import 'dart:convert';

List<ShowData> userModelDataFromJson(String str) =>
    List<ShowData>.from(json.decode(str).map((x) => ShowData.fromJson(x)));

String userModelDataToJson(List<ShowData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowData {
  int? userId;
  int? otpId;
  int? otp;
  String? status;
  String? message;

  ShowData({this.userId, this.otpId, this.otp, this.status, this.message});

  ShowData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    otpId = json['otp_id'];
    otp = json['otp'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['otp_id'] = this.otpId;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}