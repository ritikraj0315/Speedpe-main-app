class ChatModel {
  int? id;
  int? user1Id;
  int? user2Id;
  String? lastMessage;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? image;

  ChatModel({
    this.id,
    this.user1Id,
    this.user2Id,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.image,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user1Id = json['user1_id'];
    user2Id = json['user2_id'];
    lastMessage = json['last_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user1_id'] = user1Id;
    data['user2_id'] = user2Id;
    data['last_message'] = lastMessage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['image'] = image;
    return data;
  }
}
