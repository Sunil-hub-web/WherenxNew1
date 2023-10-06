

import 'dart:convert';

List<ViewDelightList> userDelightFromJson(String str) =>
    List<ViewDelightList>.from(json.decode(str).map((x) => ViewDelightList.fromJson(x)));

String userDelightToJson(List<ViewDelightList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class ViewDelightList {
  String? status;
  String? message;
  List<UserInfo>? userInfo;

  ViewDelightList({this.status, this.message, this.userInfo});

  ViewDelightList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user_info'] != null) {
      userInfo = <UserInfo>[];
      json['user_info'].forEach((v) {
        userInfo!.add(new UserInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? delightName;
  String? imageUrl;

  UserInfo({this.id, this.delightName, this.imageUrl});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    delightName = json['delight_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delight_name'] = this.delightName;
    data['image_url'] = this.imageUrl;
    return data;
  }
}