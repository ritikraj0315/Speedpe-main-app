import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/styles.dart';
import 'package:six_cash/view/base/custom_text_field.dart';

class InputSection extends StatefulWidget {
  final TextEditingController? occupationController, fNameController,lNameController,emailController;
   const InputSection({
     Key? key,
     this.occupationController,
     this.fNameController,
     this.lNameController,
     this.emailController,
   }) : super(key: key);

  @override
  State<InputSection> createState() => _InputSectionState();
}

class _InputSectionState extends State<InputSection> {
  final FocusNode occupationFocus = FocusNode();
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode emailNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller){
      return Container(
        color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeLarge),
      child: Column(
        children: [
          CustomTextField(
            fillColor: Theme.of(context).cardColor,
            hintText: 'occupation'.tr,
            isShowBorder: true,
            controller: widget.occupationController,
            focusNode: occupationFocus,
            nextFocus: firstNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),

          CustomTextField(
            fillColor: Theme.of(context).cardColor,
            hintText: 'first_name'.tr,
            isShowBorder: true,
            controller: widget.fNameController,
            focusNode: firstNameFocus,
            nextFocus: lastNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeLarge,
          ),

          CustomTextField(
            fillColor: Theme.of(context).cardColor,
            hintText: 'last_name'.tr,
            isShowBorder: true,
            controller: widget.lNameController,
            focusNode: lastNameFocus,
            nextFocus: emailNameFocus,
            inputType: TextInputType.name,
            capitalization: TextCapitalization.words,
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraExtraLarge,
          ),

        Column(
            children: [

              Row(
                children: [
                  Text('email_address'.tr, style: walsheimBold.copyWith(
                      color: Theme.of(context).focusColor,
                      fontSize: 20,
                    ),
                  ),

                  Text('(${'optional'.tr})', style: walsheimBold.copyWith(
                      color: Theme.of(context).focusColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraExtraLarge,
              ),

              CustomTextField(
                fillColor: Theme.of(context).cardColor,
                hintText: 'type_email_address'.tr,
                isShowBorder: true,
                controller: widget.emailController,
                focusNode: emailNameFocus,
                inputType: TextInputType.emailAddress,
              ),
            ],
          ) ,

        ],
      ),
    );
    });
  }
}
