class InviteMemberModel {
  String? uniqueId;
  String? fName;
  String? lName;
  String? username;
  String? image;
  int? isExists;

  InviteMemberModel({
    this.uniqueId,
    this.fName,
    this.lName,
    this.username,
    this.image,
    this.isExists,
  });

  InviteMemberModel.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    fName = json['f_name'];
    lName = json['l_name'];
    username = json['username'];
    image = json['image'];
    isExists = json['isExists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['username'] = username;
    data['image'] = image;
    data['isExists'] = isExists;
    return data;
  }
}
