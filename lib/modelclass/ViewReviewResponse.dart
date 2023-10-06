class ViewReviewResponse {
  String? status;
  String? message;
  List<ReviewDetails>? reviewDetails;

  ViewReviewResponse({this.status, this.message, this.reviewDetails});

  ViewReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['review_details'] != null) {
      reviewDetails = <ReviewDetails>[];
      json['review_details'].forEach((v) {
        reviewDetails!.add(new ReviewDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.reviewDetails != null) {
      data['review_details'] =
          this.reviewDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReviewDetails {
  int? id;
  int? userId;
  String? reviewDate;
  String? reviewerName;
  String? restaurantName;
  String? placeId;
  String? rating;
  String? message;
  String? profilePhoto;

  ReviewDetails(
      {this.id,
        this.userId,
        this.reviewDate,
        this.reviewerName,
        this.restaurantName,
        this.placeId,
        this.rating,
        this.message,
        this.profilePhoto});

  ReviewDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    reviewDate = json['review_date'];
    reviewerName = json['reviewer_name'];
    restaurantName = json['restaurant_name'];
    placeId = json['place_id'];
    rating = json['rating'];
    message = json['message'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['review_date'] = this.reviewDate;
    data['reviewer_name'] = this.reviewerName;
    data['restaurant_name'] = this.restaurantName;
    data['place_id'] = this.placeId;
    data['rating'] = this.rating;
    data['message'] = this.message;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}