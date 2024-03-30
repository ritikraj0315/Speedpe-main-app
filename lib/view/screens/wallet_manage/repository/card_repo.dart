import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class CardRepo{
  final ApiClient apiClient;

  CardRepo({required this.apiClient});

  Future<Response> getCardsList() async {
    return await apiClient.getData(AppConstants.customerGetCard);
  }
}