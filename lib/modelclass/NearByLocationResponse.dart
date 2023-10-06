class NearByLocationResponse {
  String? status;
  String? message;
  List<LocationList>? locationList;

  NearByLocationResponse({this.status, this.message, this.locationList});

  NearByLocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['location_list'] != null) {
      locationList = <LocationList>[];
      json['location_list'].forEach((v) {
        locationList!.add(new LocationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.locationList != null) {
      data['location_list'] =
          this.locationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationList {
  int? id;
  int? userId;
  String? namefromDelightlist;
  String? delightName;
  String? name;
  String? latitude;
  String? longitude;
  String? placeId;
  String? photolink;
  String? city;
  String? state;
  String? zip;
  String? opentime;
  String? closetime;
  String? openfromto;
  String? rating;
  String? commentsrating;
  double? distance;

  LocationList(
      {this.id,
        this.userId,
        this.namefromDelightlist,
        this.delightName,
        this.name,
        this.latitude,
        this.longitude,
        this.placeId,
        this.photolink,
        this.city,
        this.state,
        this.zip,
        this.opentime,
        this.closetime,
        this.openfromto,
        this.rating,
        this.commentsrating,
        this.distance});

  LocationList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    namefromDelightlist = json['namefromDelightlist'];
    delightName = json['delight_name'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeId = json['place_id'];
    photolink = json['photolink'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    opentime = json['opentime'];
    closetime = json['closetime'];
    openfromto = json['openfromto'];
    rating = json['rating'];
    commentsrating = json['commentsrating'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['namefromDelightlist'] = this.namefromDelightlist;
    data['delight_name'] = this.delightName;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['place_id'] = this.placeId;
    data['photolink'] = this.photolink;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['opentime'] = this.opentime;
    data['closetime'] = this.closetime;
    data['openfromto'] = this.openfromto;
    data['rating'] = this.rating;
    data['commentsrating'] = this.commentsrating;
    data['distance'] = this.distance;
    return data;
  }
}