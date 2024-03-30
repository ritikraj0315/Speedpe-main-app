class WebsiteLinkModel {
  String? name;
  String? image;
  String? url;
  String? category;

  WebsiteLinkModel({
    this.name,
    this.image,
    this.url,
    this.category,
  });

  WebsiteLinkModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    url = json['url'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['url'] = url;
    data['category'] = category;
    return data;
  }
}
