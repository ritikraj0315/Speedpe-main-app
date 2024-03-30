class CardModel {
  String? image;
  String? encryptedCardDetails;

  CardModel({this.image, this.encryptedCardDetails});

  CardModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    encryptedCardDetails = json['decrypted_card_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['decrypted_card_details'] = encryptedCardDetails;
    return data;
  }
}
