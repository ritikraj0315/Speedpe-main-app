import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/profile_screen_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/custom_snackbar.dart';

class UpdateUsernameScreen extends StatefulWidget {
  final String? phoneNumber;

  const UpdateUsernameScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<UpdateUsernameScreen> createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  final TextEditingController _textFieldController = TextEditingController();

  checkUsernameResponse({required String username}) {
    String username0 = username;
    if (username0.isEmpty) {
      showCustomSnackBar('please_give_your_username'.tr, isError: true);
    } else if (username0.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      showCustomSnackBar('username_not_contain_spatial_characters'.tr,
          isError: true);
    } else {
      Get.find<AuthController>().checkUsername(username).then((value) {
        if (value.statusCode == 200) {
          showSheet(context, value.body['username']);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Tell us\nAbout you.'.tr,
                  textAlign: TextAlign.start,
                  style: walsheimBold.copyWith(
                    color: Theme.of(context).focusColor,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.radiusSizeSmall),
                    color: Theme.of(context).cardColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        // Adjust padding for the icon
                        child: SizedBox(
                          height: 22,
                          width: 22,
                          child: Image.asset(
                            Images.profileIcon,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textFieldController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                            // Deny whitespace
                          ],
                          onChanged: (value) {
                            setState(() {
                              // Update the filteredList based on the search query
                              //filteredList = websiteLinkController.getSearchWebsiteList(value);
                            });
                          },
                          keyboardType: TextInputType.name,
                          style: walsheimRegular.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).focusColor,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username'.tr,
                            hintStyle: walsheimRegular.copyWith(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'By clicking Continue, you agree to our ',
                    style: walsheimRegular.copyWith(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkUsernameResponse(username: _textFieldController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: Container(
                    height: 55,
                    alignment: Alignment.center,
                    child: Text(
                      "Continue",
                      style: walsheimMedium.copyWith(
                        fontSize: 15,
                      ),
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

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}

void showSheet(context, String username) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Wrap(
            spacing: 60,
            children: <Widget>[
              Container(height: 10),
              Text(
                '@$username, available!'.tr,
                textAlign: TextAlign.start,
                style: walsheimBold.copyWith(
                  color: Theme.of(context).focusColor,
                  fontSize: 25,
                ),
              ),
              Container(height: 10),
              Text(
                'This username is available and can be used for your account.',
                textAlign: TextAlign.start,
                style: walsheimRegular.copyWith(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              Container(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.find<AuthController>()
                          .updateUsername(username)
                          .then((value) {
                        if (value.statusCode == 200) {
                          //Get.to(const HomeScreen());
                          getBackScreen();
                          Get.find<ProfileController>()
                              .profileData(reload: true);
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).indicatorColor, backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Text(
                        "Done",
                        style: walsheimMedium.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Try another",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
