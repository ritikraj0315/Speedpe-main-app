class GroupMemberModel {
  int? id;
  int? userId;
  int? groupChatId;
  int? memberType;
  String? pendingAmount;
  int? requestStatus;
  String? joinedAt;
  String? memberFirstName;
  String? memberLastName;
  String? memberUsername;
  String? memberImage;

  GroupMemberModel({
    this.id,
    this.userId,
    this.groupChatId,
    this.memberType,
    this.pendingAmount,
    this.requestStatus,
    this.joinedAt,
    this.memberFirstName,
    this.memberLastName,
    this.memberUsername,
    this.memberImage,
  });

  GroupMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupChatId = json['group_chat_id'];
    memberType = json['member_type'];
    pendingAmount = json['pending_amount'];
    requestStatus = json['request_status'];
    joinedAt = json['joined_at'];
    memberFirstName = json['f_name'];
    memberLastName = json['l_name'];
    memberUsername = json['username'];
    memberImage = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['group_chat_id'] = groupChatId;
    data['member_type'] = memberType;
    data['pending_amount'] = pendingAmount;
    data['request_status'] = requestStatus;
    data['joined_at'] = joinedAt;
    data['f_name'] = memberFirstName;
    data['l_name'] = memberLastName;
    data['username'] = memberUsername;
    data['image'] = memberImage;
    return data;
  }
}
