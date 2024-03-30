class BannerModel {
  String? title;
  String? image;
  String? url;
  String? receiver;

  BannerModel({this.title, this.image, this.url, this.receiver});

  BannerModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
    receiver = json['receiver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['url'] = url;
    data['receiver'] = receiver;
    return data;
  }
}