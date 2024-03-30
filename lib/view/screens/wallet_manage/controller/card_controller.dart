import 'package:six_cash/data/api/api_checker.dart';
import 'package:get/get.dart';

import '../model/card_model.dart';
import '../repository/card_repo.dart';

class CardController extends GetxController implements GetxService {
  final CardRepo cardRepo;

  CardController({required this.cardRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<CardModel>? _cardList;

  List<CardModel>? get cardList => _cardList;

  Future getCardList(bool reload, {bool isUpdate = true}) async {
    if (_cardList == null || reload) {
      _isLoading = true;
      _cardList = null;
      if (isUpdate) {
        update();
      }
    }
    if (_cardList == null) {
      Response response = await cardRepo.getCardsList();
      if (response.statusCode == 200) {
        _cardList = [];
        response.body.forEach((card) {
          _cardList!.add(CardModel.fromJson(card));
        });
      } else {
        _cardList = [];
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }
}
