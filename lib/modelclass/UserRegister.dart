
import 'dart:convert';

List<UserRegister> userRegisterFromJson(String str) =>
    List<UserRegister>.from(json.decode(str).map((x) => UserRegister.fromJson(x)));

String userRegisterToJson(List<UserRegister> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRegister {
  String? status;
  String? message;
  Data? data;

  UserRegister({this.status, this.message, this.data});

  UserRegister.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? country;
  String? state;
  String? city;
  int? radius;

  Data(
      {this.id,
        this.name,
        this.email,
        this.country,
        this.state,
        this.city,
        this.radius});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['radius'] = this.radius;
    return data;
  }
}