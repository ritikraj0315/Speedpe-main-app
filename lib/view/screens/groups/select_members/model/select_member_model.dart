class SelectMemberModel {
  String? uniqueId;
  String? fName;
  String? lName;
  String? username;
  String? image;

  SelectMemberModel({
    this.uniqueId,
    this.fName,
    this.lName,
    this.username,
    this.image,
  });

  SelectMemberModel.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    fName = json['f_name'];
    lName = json['l_name'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['username'] = username;
    data['image'] = image;
    return data;
  }
}
