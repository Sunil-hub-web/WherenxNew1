class RecentPinResponse {
  String? status;
  String? message;
  List<RecentPin>? recentPin;

  RecentPinResponse({this.status, this.message, this.recentPin});

  RecentPinResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['recent_pin'] != null) {
      recentPin = <RecentPin>[];
      json['recent_pin'].forEach((v) {
        recentPin!.add(new RecentPin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.recentPin != null) {
      data['recent_pin'] = this.recentPin!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentPin {
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
  String? createdAt;

  RecentPin(
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
        this.commentsrating,
        this.createdAt});

  RecentPin.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
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
    data['created_at'] = this.createdAt;
    return data;
  }
}