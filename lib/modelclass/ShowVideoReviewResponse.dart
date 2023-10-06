class ShowVideoReviewResponse {
  String? status;
  String? message;
  List<VideoReviewDetails>? videoReviewDetails;

  ShowVideoReviewResponse({this.status, this.message, this.videoReviewDetails});

  ShowVideoReviewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['video_review_details'] != null) {
      videoReviewDetails = <VideoReviewDetails>[];
      json['video_review_details'].forEach((v) {
        videoReviewDetails!.add(new VideoReviewDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.videoReviewDetails != null) {
      data['video_review_details'] =
          this.videoReviewDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoReviewDetails {
  int? id;
  int? userId;
  String? reviewDate;
  String? reviewerName;
  String? restaurantName;
  String? placeId;
  String? rating;
  String? video;
  String? message;

  VideoReviewDetails(
      {this.id,
        this.userId,
        this.reviewDate,
        this.reviewerName,
        this.restaurantName,
        this.placeId,
        this.rating,
        this.video,
        this.message});

  VideoReviewDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    reviewDate = json['review_date'];
    reviewerName = json['reviewer_name'];
    restaurantName = json['restaurant_name'];
    placeId = json['place_id'];
    rating = json['rating'];
    video = json['video'];
    message = json['message'];
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
    data['video'] = this.video;
    data['message'] = this.message;
    return data;
  }
}