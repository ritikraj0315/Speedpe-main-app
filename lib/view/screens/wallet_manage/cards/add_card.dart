import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:six_cash/util/dimensions.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_snackbar.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _textCardFieldController =
      TextEditingController();
  final TextEditingController _textExpiryFieldController =
      TextEditingController();
  final TextEditingController _textNameFieldController =
      TextEditingController();

  bool _isAddCardButtonEnabled = true;
  String selectedCardType = '';

  @override
  void initState() {
    super.initState();
    selectCardType('Debit');
  }

  void selectCardType(String tag) {
    setState(() {
      selectedCardType = tag;
    });
  }

  addCardResponse(
      {required String cardNumber,
      required String cardExpiry,
      required String cardHolderName}) {
    _isAddCardButtonEnabled = false;
    String cleanedCardNumber = cardNumber.replaceAll(" ", "");
    if (cleanedCardNumber.isEmpty || cardExpiry.isEmpty) {
      showCustomSnackBar('All fields are mandatory'.tr, isError: true);
      _isAddCardButtonEnabled = true;
    } else if (cleanedCardNumber.length < 16) {
      showCustomSnackBar('Enter correct card number'.tr, isError: true);
      _isAddCardButtonEnabled = true;
    } else {
      Get.find<AuthController>()
          .addCardDetails(cleanedCardNumber.trim(), cardExpiry, cardHolderName, selectedCardType.toString())
          .then((value) {
        if (value.statusCode == 200) {
          getBackScreen();
        } else {
          _isAddCardButtonEnabled = true;
        }
      });
    }
  }

  void _updateCardNumber(String value) {
    String cleanedText = value.replaceAll(RegExp(r'\D'), '');
    final chunkedText = <String>[];
    for (int i = 0; i < cleanedText.length; i += 4) {
      chunkedText.add(cleanedText.substring(i, i + 4));
    }
    setState(() {
      _textCardFieldController.text = chunkedText.join(' ').trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppbar(title: 'Add Card'),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 90,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    ColorResources.blueButtonGradientColor,     // Start color
                                    ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                    ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                    ColorResources.purpleButtonGradientColor,  // End color
                                  ],
                                  begin: Alignment.topLeft,    // Gradient start position
                                  end: Alignment.bottomRight,  // Gradient end position
                                  stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                                ).createShader(bounds);
                              },
                              child: Image.asset(
                                Images.cardIcon,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textCardFieldController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _updateCardNumber(value);
                              });
                            },
                            style: walsheimRegular.copyWith(
                              fontSize: 15,
                              color: Theme.of(context).focusColor,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Card number'.tr,
                              hintStyle: walsheimRegular.copyWith(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    ColorResources.blueButtonGradientColor,     // Start color
                                    ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                    ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                    ColorResources.purpleButtonGradientColor,  // End color
                                  ],
                                  begin: Alignment.topLeft,    // Gradient start position
                                  end: Alignment.bottomRight,  // Gradient end position
                                  stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                                ).createShader(bounds);
                              },
                              child: Image.asset(
                                Images.dateIcon,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textExpiryFieldController,
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
                              hintText: 'Expiry date'.tr,
                              hintStyle: walsheimRegular.copyWith(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                          child: SizedBox(
                            height: 22,
                            width: 22,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    ColorResources.blueButtonGradientColor,     // Start color
                                    ColorResources.orangeButtonGradientColor,     // Mid 1 color
                                    ColorResources.pinkButtonGradientColor,   // Mid 2 color
                                    ColorResources.purpleButtonGradientColor,  // End color
                                  ],
                                  begin: Alignment.topLeft,    // Gradient start position
                                  end: Alignment.bottomRight,  // Gradient end position
                                  stops: const [0.0, 0.33, 0.66, 1.0], // Position stops for each color
                                ).createShader(bounds);
                              },
                              child: Image.asset(
                                Images.profileIcon,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _textNameFieldController,
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
                              hintText: 'Card holder name '.tr,
                              hintStyle: walsheimRegular.copyWith(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Select card type'.tr,
                        textAlign: TextAlign.start,
                        style: walsheimRegular.copyWith(
                          color: Theme.of(context).focusColor,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          buildCardTypeButton('Debit'),
                          buildCardTypeButton('Credit'),
                          buildCardTypeButton('Prepaid'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'By clicking add card, you agree to our ',
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
                     // if (_isAddCardButtonEnabled) {
                        addCardResponse(
                            cardNumber:
                            _textCardFieldController.text.trim().toString(),
                            cardExpiry:
                            _textExpiryFieldController.text.toString(),
                            cardHolderName:
                            _textNameFieldController.text.toString());
                      //}
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
                        "Add Card",
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
      ),
    );
  }

  Widget buildCardTypeButton(String type) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            selectCardType(type);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                color: selectedCardType == type
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).highlightColor.withOpacity(0.01),
                      blurRadius: 40,
                      offset: const Offset(0, 4))
                ]),
            child: Text(
              type,
              style: walsheimMedium.copyWith(
                fontSize: 13,
                color: selectedCardType == type
                    ? Theme.of(context).indicatorColor
                    : Theme.of(context).focusColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

Future<bool?> getBackScreen() async {
  Get.offAndToNamed(RouteHelper.navbar, arguments: false);
  return null;
}
