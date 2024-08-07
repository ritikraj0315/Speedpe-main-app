import 'package:six_cash/data/api/api_checker.dart';
import 'package:get/get.dart';
import 'package:six_cash/view/screens/bill_manage/model/utilityservice_models.dart';

import '../model/utilityoperator_models.dart';
import '../repository/billmanage_repo.dart';

class BillManageController extends GetxController implements GetxService {
  final BillManageRepo billManageRepo;

  BillManageController({required this.billManageRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<UtilityServiceModel>? _utilityServiceListList;

  List<UtilityServiceModel>? get utilityServiceList => _utilityServiceListList;

  List<UtilityOperatorModel>? _utilityOperatorListList;

  List<UtilityOperatorModel>? get utilityOperatorList =>
      _utilityOperatorListList;

  Future getUtilityServiceList(bool reload, {bool isUpdate = true}) async {
    if (_utilityServiceListList == null || reload) {
      _utilityServiceListList = null;
      _isLoading = true;
      if (isUpdate) {
        update();
      }
    }
    if (_utilityServiceListList == null) {
      _utilityServiceListList = [];
      Response response = await billManageRepo.getUtilityListApi();
      if (response.body != null &&
          response.body != {} &&
          response.statusCode == 200) {
        _utilityServiceListList = [];
        response.body.forEach((website) {
          _utilityServiceListList!.add(UtilityServiceModel.fromJson(website));
        });
      } else {
        _utilityServiceListList = [];
        ApiChecker.checkApi(response);
      }

      _isLoading = false;
      update();
    }
  }

  Future getUtilityOperatorList(bool reload, {bool isUpdate = true}) async {
    if (_utilityOperatorListList == null || reload) {
      _utilityOperatorListList = null;
      _isLoading = true;
      if (isUpdate) {
        update();
      }
    }
    if (_utilityOperatorListList == null) {
      _utilityOperatorListList = [];
      Response response = await billManageRepo.getUtilityOperatorListApi();
      if (response.body != null &&
          response.body != {} &&
          response.statusCode == 200) {
        _utilityOperatorListList = [];
        response.body.forEach((website) {
          _utilityOperatorListList!.add(UtilityOperatorModel.fromJson(website));
        });
      } else {
        _utilityOperatorListList = [];
        ApiChecker.checkApi(response);
      }

      _isLoading = false;
      update();
    }
  }

  List<UtilityServiceModel> getFilteredWebsiteList(String category) {
    return utilityServiceList
            ?.where((website) =>
                website.category?.toLowerCase().contains(category) ?? false)
            .toList() ??
        [];
  }

  List<UtilityServiceModel> getReversedFilteredWebsiteList(String category) {
    List<UtilityServiceModel> filteredList = getFilteredWebsiteList(category);
    return filteredList.reversed.toList();
  }

  List<UtilityServiceModel> getExcludedWebsiteList(String category) {
    return utilityServiceList!
        .where((website) =>
            !(website.category?.toLowerCase().contains(category) ?? false))
        .toList();
  }

  List<UtilityServiceModel> getSearchWebsiteList(String query) {
    List<UtilityServiceModel> filteredList = getExcludedWebsiteList("ad");
    return filteredList
            .where((website) =>
                website.name?.toLowerCase().contains(query) ?? false)
            .toList() ??
        [];
  }
}
