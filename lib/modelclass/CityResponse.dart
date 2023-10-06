
import 'dart:convert';

List<CityResponse> userGetStateFromJson(String str) =>
    List<CityResponse>.from(json.decode(str).map((x) => CityResponse.fromJson(x)));

String userGetStateToJson(List<CityResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityResponse {
  int? id;
  String? name;

  CityResponse({this.id, this.name});

  CityResponse.fromJson(Map<String, dynamic> json) {
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