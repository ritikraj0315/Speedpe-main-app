class GroupMessagesModel {
  int? id;
  int? senderId;
  String? senderFirstName;
  String? senderLastName;
  String? senderImage;
  String? questionContent;
  String? messageContent;
  int? type;
  String? createdAt;

  GroupMessagesModel({
    this.id,
    this.senderId,
    this.senderFirstName,
    this.senderLastName,
    this.senderImage,
    this.questionContent,
    this.messageContent,
    this.type,
    this.createdAt,
  });

  GroupMessagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    senderFirstName = json['sender_first_name'];
    senderLastName = json['sender_last_name'];
    senderImage = json['sender_image'];
    questionContent = json['question'];
    messageContent = json['message_content'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['sender_first_name'] = senderFirstName;
    data['sender_last_name'] = senderLastName;
    data['sender_image'] = senderImage;
    data['question'] = questionContent;
    data['message_content'] = messageContent;
    data['type'] = type;
    data['created_at'] = createdAt;
    return data;
  }
}
