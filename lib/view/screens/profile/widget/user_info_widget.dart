import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/controller/splash_controller.dart';
import 'package:six_cash/data/model/response/user_info.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_image.dart';
import 'package:six_cash/view/base/custom_ink_well.dart';
import '../../kyc_verify/select_kyc_method_screen.dart';
import '../../social_media/profile_view/my_profile_view.dart';
import 'profile_shimmer.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) => profileController.isLoading
          ? const ProfileShimmer()
          : Container(
              padding: const EdgeInsets.fromLTRB(
                Dimensions.paddingSizeDefault,
                20,
                Dimensions.paddingSizeDefault,
                0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      profileController.userInfo != null
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => const MyProfileViewScreen());
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      child: CustomImage(
                                        fit: BoxFit.cover,
                                        image:
                                            "${Get.find<SplashController>().configModel!.baseUrls!.customerImageUrl}/${profileController.userInfo!.image}",
                                        placeholder: Images.avatar,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        '${profileController.userInfo!.fName} ${profileController.userInfo!.lName}',
                                        style: walsheimMedium.copyWith(
                                          color: Theme.of(context).focusColor,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        '${profileController.userInfo!.phone}',
                                        style: walsheimRegular.copyWith(
                                          color: Theme.of(context)
                                              .highlightColor
                                              .withOpacity(
                                                  Get.isDarkMode ? 0.8 : 0.5),
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.start,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),

                      // InkWell(
                      //   onTap: () => showModalBottomSheet(
                      //     context: context,
                      //     isScrollControlled: true,
                      //     isDismissible: false,
                      //     shape: const RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSizeLarge)),
                      //     ),
                      //     builder: (context) => const ProfileQRCodeBottomSheet(),
                      //   ),
                      //   child: GetBuilder<ProfileController>(builder: (controller) {
                      //     return Container(
                      //       decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).secondaryHeaderColor),
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: SvgPicture.string(controller.userInfo!.qrCode!, height: 24, width: 24,),
                      //     );
                      //   }),
                      // )
                    ],
                  ),
                  const SizedBox(height: 15),
                  if (profileController.userInfo!.kycStatus !=
                      KycVerification.approve)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            profileController.userInfo!.kycStatus ==
                                    KycVerification.needApply
                                ? 'kyc_verification_is_not'.tr
                                : profileController.userInfo!.kycStatus ==
                                        KycVerification.pending
                                    ? 'your_verification_request_is'.tr
                                    : 'your_verification_is_denied'.tr,
                            style: walsheimRegular.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        CustomInkWell(
                          onTap: () =>
                              Get.to(() => const SelectKycMethodScreen()),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                              vertical: Dimensions.paddingSizeExtraSmall,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeExtraSmall),
                              color: Theme.of(context)
                                  .colorScheme
                                  .error
                                  .withOpacity(0.8),
                            ),
                            child: Text(
                              profileController.userInfo!.kycStatus ==
                                      KycVerification.needApply
                                  ? 'click_to_verify'.tr
                                  : profileController.userInfo!.kycStatus ==
                                          KycVerification.pending
                                      ? 'edit'.tr
                                      : 're_apply'.tr,
                              style: walsheimMedium.copyWith(
                                  color: Theme.of(context).cardColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
