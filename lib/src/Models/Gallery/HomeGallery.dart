

class HomeGallery {
  int id;
  String property;
  String url;
  String createdAt;
  String updatedAt;

  HomeGallery(
      {this.id, this.property, this.url, this.createdAt, this.updatedAt});

  HomeGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property = json['property'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property'] = this.property;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}