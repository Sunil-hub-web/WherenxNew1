

class ProfileImageSuccess {
  String? status;
  String? message;
  String? userData;

  ProfileImageSuccess({this.status, this.message, this.userData});

  ProfileImageSuccess.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['user_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_data'] = this.userData;
    return data;
  }
}