class ViewUserResponse {
  String? status;
  String? message;
  UserInfo? userInfo;

  ViewUserResponse({this.status, this.message, this.userInfo});

  ViewUserResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? email;
  String? country;
  String? state;
  String? city;
  int? radius;

  UserInfo(
      {this.id,
        this.name,
        this.email,
        this.country,
        this.state,
        this.city,
        this.radius});

  UserInfo.fromJson(Map<String, dynamic> json) {
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
