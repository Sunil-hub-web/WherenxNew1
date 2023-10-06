
import 'dart:convert';
import 'dart:core';

List<ProfileImageResponse> userModelDataFromJson(String str) =>
    List<ProfileImageResponse>.from(json.decode(str).map((x) => ProfileImageResponse.fromJson(x)));

String userModelDataToJson(List<ProfileImageResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileImageResponse {
  String? status;
  String? message;
  String? image;

  ProfileImageResponse({this.status, this.message, this.image});

  ProfileImageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image'] = this.image;
    return data;
  }
}