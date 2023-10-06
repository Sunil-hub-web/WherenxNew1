class VideoReviewResponse {
  String? status;
  String? message;
  UserData? userData;

  VideoReviewResponse({this.status, this.message, this.userData});

  VideoReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userId;
  String? reviewDate;
  String? reviewerName;
  String? restaurantName;
  String? placeId;
  String? rating;
  String? video;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserData(
      {this.userId,
        this.reviewDate,
        this.reviewerName,
        this.restaurantName,
        this.placeId,
        this.rating,
        this.video,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    reviewDate = json['review_date'];
    reviewerName = json['reviewer_name'];
    restaurantName = json['restaurant_name'];
    placeId = json['place_id'];
    rating = json['rating'];
    video = json['video'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['review_date'] = this.reviewDate;
    data['reviewer_name'] = this.reviewerName;
    data['restaurant_name'] = this.restaurantName;
    data['place_id'] = this.placeId;
    data['rating'] = this.rating;
    data['video'] = this.video;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}