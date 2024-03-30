import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:six_cash/controller/kyc_verify_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_app_bar.dart';
import 'package:six_cash/view/base/custom_button.dart';
import 'package:six_cash/view/base/custom_drop_down_button.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import 'package:six_cash/view/base/custom_snackbar.dart';
import 'package:six_cash/view/base/custom_text_field.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';

class KycVerifyScreen extends StatefulWidget {
  final String methodName;

  const KycVerifyScreen({Key? key, required this.methodName}) : super(key: key);

  @override
  State<KycVerifyScreen> createState() => _KycVerifyScreenState();
}

class _KycVerifyScreenState extends State<KycVerifyScreen> {
  final TextEditingController _identityNumberController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    Get.find<KycVerifyController>().initialSelect();

    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
        _dobController.text = formattedDate;
      });
    }
  }

  bool isEighteenOrOlder(String dob) {
    List<String> parts = dob.split('-');
    if (parts.length != 3) {
      return false;
    }
    int day = int.tryParse(parts[0]) ?? 0;
    int month = int.tryParse(parts[1]) ?? 0;
    int year = int.tryParse(parts[2]) ?? 0;
    DateTime selectedDate = DateTime(year, month, day);

    DateTime now = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);
    return !selectedDate.isAfter(eighteenYearsAgo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppbar(title: 'kyc_verification'.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault,
            vertical: Dimensions.paddingSizeLarge),
        child: GetBuilder<KycVerifyController>(builder: (kycVerifyController) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _firstNameController,
                      fillColor: Theme.of(context).cardColor,
                      isShowBorder: true,
                      maxLines: 1,
                      hintText: 'First name*',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextField(
                      controller: _lastNameController,
                      fillColor: Theme.of(context).cardColor,
                      isShowBorder: true,
                      maxLines: 1,
                      hintText: 'Last name*',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              CustomTextField(
                controller: _identityNumberController,
                fillColor: Theme.of(context).cardColor,
                isShowBorder: true,
                maxLines: 1,
                hintText: '${widget.methodName} Number*',
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: CustomTextField(
                      controller: _dobController,
                      fillColor: Theme.of(context).cardColor,
                      isShowBorder: true,
                      isEnabled: false,
                      suffixIconUrl: Images.dateIcon,
                      isShowSuffixIcon: true,
                      maxLines: 1,
                      hintText: 'Dob*',
                    ),
                  )),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomDropDownButton(
                      value: kycVerifyController.dropDownGenderSelectedValue,
                      itemList: kycVerifyController.dropGenderList,
                      onChanged: (value) =>
                          kycVerifyController.dropDownGenderChange(value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              CustomTextField(
                controller: _addressLine1Controller,
                fillColor: Theme.of(context).cardColor,
                isShowBorder: true,
                maxLines: 1,
                hintText: 'Address Line 1*'.tr,
              ),
              const SizedBox(height: Dimensions.fontSizeDefault),
              CustomTextField(
                controller: _addressLine2Controller,
                fillColor: Theme.of(context).cardColor,
                isShowBorder: true,
                maxLines: 1,
                hintText: 'Address Line 2'.tr,
              ),
              const SizedBox(height: Dimensions.fontSizeDefault),
              CustomTextField(
                controller: _pinCodeController,
                fillColor: Theme.of(context).cardColor,
                inputType: TextInputType.number,
                isShowBorder: true,
                maxLines: 1,
                hintText: 'Pin Code*'.tr,
              ),
              const SizedBox(height: Dimensions.fontSizeDefault),
              Text('upload_your_image'.tr,
                  style: walsheimMedium.copyWith(
                      color: ColorResources.lightGrayColor, fontSize: 15)),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: kycVerifyController.identityImage.length + 1,
                  itemBuilder: (BuildContext context, index) {
                    if (index + 1 ==
                        kycVerifyController.identityImage.length + 1) {
                      return _borderWidget(null);
                    }
                    return kycVerifyController.identityImage.isNotEmpty
                        ? Row(
                            children: [
                              Stack(
                                children: [
                                  _borderWidget(kycVerifyController
                                      .identityImage[index].path),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () => kycVerifyController
                                          .removeImage(index),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.2),
                                              borderRadius: const BorderRadius
                                                  .all(
                                                  Radius.circular(Dimensions
                                                      .paddingSizeDefault))),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  width: Dimensions.paddingSizeDefault),
                            ],
                          )
                        : const SizedBox();
                  },
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              Center(
                child: kycVerifyController.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 55,
                        child: CustomButton(
                            buttonText: 'Continue'.tr,
                            onTap: () {
                              if (_identityNumberController.text.isEmpty ||
                                  _firstNameController.text.isEmpty ||
                                  _lastNameController.text.isEmpty ||
                                  _dobController.text.isEmpty ||
                                  _addressLine1Controller.text.isEmpty ||
                                  _pinCodeController.text.isEmpty) {
                                showCustomSnackBar(
                                    'All fields are mandatory'.tr);
                              } else if (kycVerifyController
                                  .identityImage.isEmpty) {
                                showCustomSnackBar(
                                    'please_upload_identity_image'.tr);
                              } else if (kycVerifyController
                                      .dropDownGenderSelectedValue ==
                                  kycVerifyController.dropGenderList[0]) {
                                showCustomSnackBar('Select gender'.tr);
                              } else if (!isEighteenOrOlder(
                                  _dobController.text)) {
                                showCustomSnackBar(
                                    'You should be 18 years old'.tr);
                              } else {
                                kycVerifyController
                                    .kycVerify(
                                        widget.methodName,
                                        _identityNumberController.text,
                                        _firstNameController.text,
                                        _lastNameController.text,
                                        _dobController.text,
                                        '${_addressLine1Controller.text} ${_addressLine2Controller.text}',
                                        _pinCodeController.text)
                                    .then((value) {
                                  Get.find<ProfileController>().profileData(
                                      isUpdate: true, reload: true);
                                });
                              }
                            },
                            color: Theme.of(context).primaryColor),
                      ),
              ),
            ]),
          );
        }),
      ),
    );
  }

  Widget _borderWidget(String? path) {
    return DottedBorder(
      dashPattern: const [10],
      borderType: BorderType.RRect,
      strokeWidth: 0.5,
      color: ColorResources.lightGrayColor,
      child: CustomInkWell(
        onTap: path != null
            ? null
            : () => Get.find<KycVerifyController>().pickImage(false),
        child: path != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.paddingSizeSmall)),
                  child: Image.file(
                    File(path),
                    width: 160,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SizedBox(
                height: 100,
                width: 160,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(Images.cameraIcon),
                ),
              ),
      ),
    );
  }
}
