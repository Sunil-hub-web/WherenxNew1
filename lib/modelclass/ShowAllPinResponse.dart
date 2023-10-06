

import 'dart:convert';

List<ShowAllPinResponse> ShowAllPinFromJson(String str) =>
    List<ShowAllPinResponse>.from(json.decode(str).map((x) => ShowAllPinResponse.fromJson(x)));

String ShowAllPinToJson(List<ShowAllPinResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowAllPinResponse {
  String? status;
  String? message;
  List<AllPinList>? allPinList;

  ShowAllPinResponse({this.status, this.message, this.allPinList});

  ShowAllPinResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['all_pin_list'] != null) {
      allPinList = <AllPinList>[];
      json['all_pin_list'].forEach((v) {
        allPinList!.add(new AllPinList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allPinList != null) {
      data['all_pin_list'] = this.allPinList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllPinList {
  int? id;
  int? userId;
  String? delightName;
  String? placeId;
  String? latitude;
  String? longitude;
  String? name;
  String? website;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? phonenumber;
  String? description;
  String? opentime;
  String? closetime;
  String? openfromto;
  String? photolink;
  String? rating;
  String? commentsrating;

  AllPinList(
      {this.id,
        this.userId,
        this.delightName,
        this.placeId,
        this.latitude,
        this.longitude,
        this.name,
        this.website,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.phonenumber,
        this.description,
        this.opentime,
        this.closetime,
        this.openfromto,
        this.photolink,
        this.rating,
        this.commentsrating});

  AllPinList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    delightName = json['delight_name'];
    placeId = json['place_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    website = json['website'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    phonenumber = json['phonenumber'];
    description = json['description'];
    opentime = json['opentime'];
    closetime = json['closetime'];
    openfromto = json['openfromto'];
    photolink = json['photolink'];
    rating = json['rating'];
    commentsrating = json['commentsrating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['delight_name'] = this.delightName;
    data['place_id'] = this.placeId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['website'] = this.website;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['phonenumber'] = this.phonenumber;
    data['description'] = this.description;
    data['opentime'] = this.opentime;
    data['closetime'] = this.closetime;
    data['openfromto'] = this.openfromto;
    data['photolink'] = this.photolink;
    data['rating'] = this.rating;
    data['commentsrating'] = this.commentsrating;
    return data;
  }
}