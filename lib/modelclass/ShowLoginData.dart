
import 'dart:convert';

List<ShowLoginData> userModelDataFromJson(String str) =>
    List<ShowLoginData>.from(json.decode(str).map((x) => ShowLoginData.fromJson(x)));

String userModelDataToJson(List<ShowLoginData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<UserInfo> userUserInfoFromJson(String str) =>
    List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromJson(x)));

String userUserInfoToJson(List<UserInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class ShowLoginData {
  String? status;
  String? message;
  UserInfo? userInfo;

  ShowLoginData({this.status, this.message, this.userInfo});

  ShowLoginData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userInfo = json['user_info'] != null
        ? UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? userId;
  String? name;
  String? email;
  String? country;
  String? state;
  String? city;

  UserInfo(
      {this.userId,
        this.name,
        this.email,
        this.country,
        this.state,
        this.city});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}