class UpdateUser {
  String? status;
  String? message;
  UserInfo? userInfo;

  UpdateUser({this.status, this.message, this.userInfo});

  UpdateUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userInfo = json['user_info'] != null ? new UserInfo.fromJson(json['user_info']) : null;
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
  String? phone;
  String? password;
  String? profilePhoto;
  String? age;
  String? gender;
  String? address;
  String? country;
  String? state;
  String? city;
  String? pincode;
  String? delightId;
  String? createdAt;
  String? updatedAt;

  UserInfo(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.password,
        this.profilePhoto,
        this.age,
        this.gender,
        this.address,
        this.country,
        this.state,
        this.city,
        this.pincode,
        this.delightId,
        this.createdAt,
        this.updatedAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    profilePhoto = json['profile_photo'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    delightId = json['delight_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['profile_photo'] = this.profilePhoto;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['delight_id'] = this.delightId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}