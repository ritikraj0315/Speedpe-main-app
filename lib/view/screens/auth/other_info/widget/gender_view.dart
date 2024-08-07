import 'package:six_cash/controller/edit_profile_controller.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_gender_card.dart';

class GenderView extends StatelessWidget {
  final bool fromEditProfile;

  const GenderView({
    Key? key,
    this.fromEditProfile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return GetBuilder<EditProfileController>(
          builder: (editProfileController) {
        String? gender = fromEditProfile
            ? editProfileController.gender
            : profileController.gender;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: Dimensions.paddingSizeExtraLarge,
            left: Dimensions.paddingSizeDefault,
            bottom: Dimensions.paddingSizeDefault,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_your_gender'.tr,
                style: walsheimBold.copyWith(
                  color: Theme.of(context).focusColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomGenderCard(
                      icon: Images.male,
                      text: 'male'.tr,
                      color: gender == 'Male'
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      onTap: () => fromEditProfile
                          ? editProfileController.setGender('Male')
                          : profileController.setGender('Male'),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    CustomGenderCard(
                      icon: Images.female,
                      text: 'female'.tr,
                      color: gender == 'Female'
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      onTap: () => fromEditProfile
                          ? editProfileController.setGender('Female')
                          : profileController.setGender('Female'),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    CustomGenderCard(
                      icon: Images.other,
                      text: 'other'.tr,
                      color: gender == 'Other'
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                      onTap: () => fromEditProfile
                          ? editProfileController.setGender('Other')
                          : profileController.setGender('Other'),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
    });
  }
}
