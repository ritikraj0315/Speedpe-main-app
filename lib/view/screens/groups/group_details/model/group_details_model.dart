class GroupDetailsModel {
  int? id;
  String? groupName;
  String? groupTag;
  String? lastMessage;
  int? type;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  GroupDetailsModel({
    this.id,
    this.groupName,
    this.groupTag,
    this.lastMessage,
    this.type,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  GroupDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    groupTag = json['group_tag'];
    lastMessage = json['last_message'];
    type = json['type'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['group_tag'] = groupTag;
    data['last_message'] = lastMessage;
    data['type'] = type;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
