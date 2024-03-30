import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:six_cash/data/api/api_checker.dart';
import 'package:six_cash/data/repository/kyc_verify_repo.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import '../data/api/api_client.dart';
import '../view/screens/kyc_verify/kyc_verified_screen.dart';
import '../view/screens/kyc_verify/verify_kyc_otp.dart';

class KycVerifyController extends GetxController implements GetxService {
  final KycVerifyRepo kycVerifyRepo;

  KycVerifyController({required this.kycVerifyRepo});

  List<XFile>? _imageFile;
  List<XFile> _identityImage = [];

  List<XFile> get identityImage => _identityImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final List<String> _dropList = [
    'select_identity_type'.tr,
    'aadhaar_card'.tr,
    'pan_card'.tr,
    'passport'.tr,
    'driving_licence'.tr,
    'nid'.tr,
    'trade_license'.tr,
  ];

  List<String> get dropList => _dropList;

  String _dropDownSelectedValue = 'select_identity_type'.tr;

  String get dropDownSelectedValue => _dropDownSelectedValue;

  void dropDownChange(String value) {
    _dropDownSelectedValue = value;
    update();
  }

  void initialSelect() {
    _dropDownSelectedValue = 'select_identity_type'.tr;
    _identityImage = [];
    _isLoading = false;
  }

  final List<String> _dropGenderList = [
    'Select gender'.tr,
    'Male'.tr,
    'Female'.tr,
    'Other'.tr,
  ];

  List<String> get dropGenderList => _dropGenderList;

  String _dropDownGenderSelectedValue = 'Select gender'.tr;

  String get dropDownGenderSelectedValue => _dropDownGenderSelectedValue;

  void dropDownGenderChange(String value) {
    _dropDownGenderSelectedValue = value;
    update();
  }

  void initialGenderSelect() {
    _dropDownGenderSelectedValue = 'Select gender'.tr;
    _identityImage = [];
    _isLoading = false;
  }

  void pickImage(bool isRemove) async {
    final ImagePicker picker = ImagePicker();
    if (isRemove) {
      _imageFile = [];
    } else {
      _imageFile = await picker.pickMultiImage(imageQuality: 30);
      if (_imageFile != null) {
        _identityImage.addAll(_imageFile!);
      }
    }
    update();
  }

  void removeImage(int index) {
    _identityImage.removeAt(index);
    update();
  }

  List<MultipartBody>? _multipartBody;

  Future<void> kycVerify(String idType, String idNumber, String firstName,
      String lastName, String dob, String address, String pinCode) async {
    Map<String, String> field = {
      'identification_type': idType,
      'identification_number': idNumber,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'gender': _dropDownGenderSelectedValue == 'Male'
          ? 'Male'
          : _dropDownGenderSelectedValue == 'Female'
              ? 'Female'
              : _dropDownGenderSelectedValue == 'Other'
                  ? 'Other'
                  : 'Select gender',
      'address': address,
      'pin_code': pinCode,
      '_method': 'put'
    };
    _multipartBody = _identityImage
        .map((image) =>
            MultipartBody('identification_image[]', File(image.path)))
        .toList();
    _isLoading = true;
    update();
    Response response = await kycVerifyRepo.kycVerifyApi(field, _multipartBody);
    if (response.statusCode == 200) {
      if (response.body['message'].contains('OTP')) {
        Get.to(() => const VerifyKycOtpScreen());
      } else {
        Get.to(() => const KycVerifiedScreen());
      }
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> kycVerifyOtp(String otp) async {
    _isLoading = true;
    update();
    Response response = await kycVerifyRepo.kycVerifyOtpApi(otp: otp);
    if (response.statusCode == 200) {
        Get.to(() => const KycVerifiedScreen());
      showCustomSnackBar(response.body['message'], isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }
}
