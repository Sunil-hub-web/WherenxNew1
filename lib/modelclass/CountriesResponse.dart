

import 'dart:convert';

List<CountriesResponse> userCountriesFromJson(String str) =>
    List<CountriesResponse>.from(json.decode(str).map((x) => CountriesResponse.fromJson(x)));

String userCountriesToJson(List<CountriesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountriesResponse {
  int? id;
  String? name;

  CountriesResponse({this.id, this.name});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}