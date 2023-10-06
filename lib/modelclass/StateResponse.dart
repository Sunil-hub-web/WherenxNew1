
import 'dart:convert';

List<StateResponse> userGetStateFromJson(String str) =>
    List<StateResponse>.from(json.decode(str).map((x) => StateResponse.fromJson(x)));

String userGetStateToJson(List<StateResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StateResponse {
  int? id;
  String? name;

  StateResponse({this.id, this.name});

  StateResponse.fromJson(Map<String, dynamic> json) {
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