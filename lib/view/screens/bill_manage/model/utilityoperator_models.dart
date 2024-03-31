class UtilityOperatorModel {
  String? title;
  String? image;
  String? opCode;
  String? infoText;

  UtilityOperatorModel({
    this.title,
    this.image,
    this.opCode,
    this.infoText,
  });

  UtilityOperatorModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    opCode = json['op_code'];
    infoText = json['info_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image'] = image;
    data['op_code'] = opCode;
    data['info_text'] = infoText;
    return data;
  }
}
