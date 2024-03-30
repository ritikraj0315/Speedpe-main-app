import 'package:get/get_connect/http/src/response/response.dart';
import 'package:six_cash/data/api/api_client.dart';
import 'package:six_cash/util/app_constants.dart';

class BillManageRepo {
  final ApiClient apiClient;

  BillManageRepo({required this.apiClient});

  Future<Response> getUtilityListApi() async {
    return await apiClient.getData(AppConstants.customerUtilityService);
  }
}
