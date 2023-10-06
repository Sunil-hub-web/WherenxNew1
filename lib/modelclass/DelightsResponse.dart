

class DelightsResponse {
  int? id;
  String? delightName;
  String? imageUrl;

  DelightsResponse({this.id, this.delightName, this.imageUrl});

  DelightsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    delightName = json['delight_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delight_name'] = this.delightName;
    data['image_url'] = this.imageUrl;
    return data;
  }
}