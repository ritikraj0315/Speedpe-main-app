import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {
  static Color getPrimaryColor() {
    return Get.isDarkMode ? const Color(0xFF1B4683) : const Color(0xFF1B4683);
  }

  static Color getPrimaryTextColor() {
    return Get.isDarkMode ? const Color(0xFF8dbac3) : const Color(0xFF8dbac3);
  }

  static Color getSecondaryHeaderColor() {
    return Get.isDarkMode ? const Color(0xFFaaa818) : const Color(0xFFaaa818);
  }

  static Color getGreyColor() {
    return Get.isDarkMode ? const Color(0xFF6f7275) : const Color(0xFF6f7275);
  }

  static Color getGreyBaseGray1() {
    return Get.isDarkMode ? const Color(0xFFd3d3d8) : const Color(0xFFd3d3d8);
  }

  static Color getLightGray() {
    return Get.isDarkMode ? const Color(0x00dbdbdb) : const Color(0x00dbdbdb);
  }

  static Color getAcceptBtn() {
    return Get.isDarkMode ? const Color(0xFF065802) : const Color(0xFF065802);
  }

  static Color getGreyBaseGray3() {
    return Get.isDarkMode ? const Color(0xFF757575) : const Color(0xFF757575);
  }

  static Color getGreyBaseGray4() {
    return Get.isDarkMode ? const Color(0xFFe3e3e8) : const Color(0xFFe3e3e8);
  }

  static Color getGreyBaseGray6() {
    return Get.isDarkMode ? const Color(0xFFb2b5c8) : const Color(0xFFb2b5c8);
  }

  static Color getSearchBg() {
    return Get.isDarkMode ? const Color(0xFF585a5c) : const Color(0xFF585a5c);
  }

  static Color getBackgroundColor() {
    return Get.isDarkMode ? const Color(0xFF070B0B) : const Color(0xFF070B0B);
  }

  static Color getBlackAndWhite() {
    return Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  }

  static Color getWhiteAndBlack() {
    return Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF070B0B);
  }

  static Color getDarkGrayColor() {
    return Get.isDarkMode ? const Color(0xFF121C1C) : const Color(0xFF121C1C);
  }

  static Color getLightAndDark() {
    return Get.isDarkMode
        ? Theme.of(Get.context!).cardColor
        : const Color(0xFF070B0B);
  }

  static Color getOccupationCardColor() {
    return Get.isDarkMode ? const Color(0xFF3c3c3c) : const Color(0xFF3c3c3c);
  }

  static Color getHintColor() {
    return Get.isDarkMode ? const Color(0xFF98a1ab) : const Color(0xFF98a1ab);
  }

  static Color getGreyBunkerColor() {
    return Get.isDarkMode ? const Color(0xFFE4E8EC) : const Color(0xFFE4E8EC);
  }

  static Color getTextColor() {
    return Get.isDarkMode ? const Color(0xFFE4E8EC) : const Color(0xFFE4E8EC);
  }

  static Color getAcceptTextColor() {
    return Get.isDarkMode ? const Color(0xFF25282B) : const Color(0xFF25282B);
  }

  static Color getNoteTextColor() {
    return Get.isDarkMode ? const Color(0xFF25282B) : const Color(0xFF25282B);
  }

  static Color getTransactionTitleColor() {
    return Get.isDarkMode ? const Color(0xFF71a8c1) : const Color(0xFF71a8c1);
  }

  static Color getTransactionTrilingColor() {
    return Get.isDarkMode ? const Color(0xFF84b1cc) : const Color(0xFF84b1cc);
  }

  static Color getWebsiteTextColor() {
    return Get.isDarkMode ? const Color(0xFF84b1cc) : const Color(0xFF84b1cc);
  }

  static Color getBalanceTextColor() {
    return Get.isDarkMode ? const Color(0xFFd7d7d7) : const Color(0xFFd7d7d7);
  }

  static Color getShadoColor() {
    return Get.isDarkMode ? const Color(0xFFededed) : const Color(0xFFededed);
  }

  //card.
  static Color getAddMoneyCardColor() {
    return Get.isDarkMode ? const Color(0xFF398343) : const Color(0xFF398343);
  }

  static Color getCashOutCardColor() {
    return Get.isDarkMode ? const Color(0xFFf57a00) : const Color(0xFFf57a00);
  }

  static Color getRequestMoneyCardColor() {
    return Get.isDarkMode ? const Color(0xFFa900a0) : const Color(0xFFa900a0);
  }

  static Color getReferFriendCardColor() {
    return Get.isDarkMode ? const Color(0xFF0083cf) : const Color(0xFF0083cf);
  }

  static Color getOthersCardColor() {
    return Get.isDarkMode ? const Color(0xFF3137c9) : const Color(0xFF3137c9);
  }

  static Color getShadowColor() {
    return Get.isDarkMode ? const Color(0xFFeeeeee) : const Color(0xFFeeeeee);
  }

  //onboarding
  static Color getOnboardingBgColor() {
    return Get.isDarkMode ? const Color(0xFF4a5361) : const Color(0xFF4a5361);
  }

  static Color getOnboardGreyColor() {
    return Get.isDarkMode ? const Color(0xFFe9e8f5) : const Color(0xFFe9e8f5);
  }

  static Color getDividerColor() {
    return Get.isDarkMode ? const Color(0xFFd9d9d9) : const Color(0xFFd9d9d9);
  }

  static Color getSupportScreenTextColor() {
    return Get.isDarkMode ? const Color(0xFFe6e6e6) : const Color(0xFFe6e6e6);
  }

  static Color getLightGrey() {
    return Get.isDarkMode ? const Color(0xFF686868) : const Color(0xFF686868);
  }

  static Color getOtpFieldColor() {
    return Get.isDarkMode ? const Color(0xFF6a6e81) : const Color(0xFF6a6e81);
  }

  static Color getInputBoxColor() {
    return Get.isDarkMode ? const Color(0xFF121C1C) : const Color(0xFF121C1C);
  }

  static Color getLimeColor() {
    return Get.isDarkMode ? const Color(0xFFB2FA63) : const Color(0xFFB2FA63);
  }

  ///#686868

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };
  static const List<Color> ssColor = [
    Color(0xFF008926),
    Color(0xFF5CAE7F),
    Color(0xFF008926),
    Color(0xFF008926),
    Color(0xFF5CAE7D),
    Color(0xFF008926),
  ];

  //
  static Color secondaryColor = const Color(0xFFE0EC53);
  static const Color primaryColor = Color(0xFF1B4683);
  static Color gradientColor = const Color(0xFF45A735);
  static Color backgroundColor = const Color(0xFFE5E5E5);
  static Color balanceTextColor = const Color(0xFF393939);
  static Color cardOrangeColor = const Color(0xFFFFCB66);
  static Color cardPinkColor = const Color(0xFFF6BDE9);
  static Color cardPestColor = const Color(0xFFACD9B3);
  static Color containerShedow = const Color(0xFF757575);
  static Color websiteTextColor = const Color(0xFF344968);
  static Color nevDefaultColor = const Color(0xFFAAAAAA);
  static Color blueColor = const Color(0xFF635BFE);
  static Color textFieldColor = const Color(0xFFF2F2F6);
  static Color otpFieldColor = const Color(0xFFF2F2F7);
  static Color redColor = const Color(0xFFFF0000);
  static Color phoneNumberColor = const Color(0xFF484848);
  static Color themeLightBackgroundColor = const Color(0xFFFAFAFA);
  static Color themeDarkBackgroundColor = const Color(0xFF343636);

  //other info
  //#6a6e81
  static Color genderDefaultColor = const Color(0xFFe3f3fd);
  static Color hintColor = const Color(0xFF8E8E93);
  static Color textFieldBorderColor = const Color(0xFFD1D1D6);

//shimmer Color
  static Color? shimmerBaseColor = Colors.grey[350];
  static Color? shimmerLightColor = Colors.grey[200];

  /// qr code scanner screen
  static Color containerColor = const Color(0xFFD1D1D6);

  static Color dividerColor = const Color(0xFFD8D8D8);
  static Color inputBoxColor = const Color(0xFFF8F8F8);

  static const Color newLimeColor = Color(0xFFB2FA63);
  static Color darkGrayColor = const Color(0xFF121C1C);
  static Color lightLimeColor = const Color(0xFFD2FAA5);


  static Color simplePinkColor = const Color(0xFFFFC0CB);
  static Color simplePurpleColor = const Color(0xFF800080);




  //new multiple theme color
  static Color limeColor = const Color(0xFFB2FA63);
  static Color purpleColor = const Color(0xFF8A26F6);
  static Color lightPurpleColor = const Color(0xFFF4EBFE);
  static Color darkPurpleColor = const Color(0xFF060508);
  static Color blueThemeColor = const Color(0xFF1B4683);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color blackColor = const Color(0xFF000000);
  static Color lightRedColor = const Color(0xFFF44336);
  static Color lightGrayColor = const Color(0xFF919B9B);

  //orange color
  static Color orangeColor = const Color(0xFFF27507);
  static Color lightOrangeColor = const Color(0xFF242424);
  static Color darkOrangeColor = const Color(0xFF0D0D0D);

  static Color blackCardColor = const Color(0xFF1D1D1D);
  static Color blackSilverColor = const Color(0xFFb5b8ba);

  static Color dayPurpleColor = const Color(0xFFA274FB);

  static Color lightBlueColor = const Color(0xFF64DA9D);

  //Celadon theme
  static Color celadonColor = const Color(0xFF387CFF);
  static Color celadonBgColor = const Color(0xFFE0EDF5);
  static Color celadonCardColor = const Color(0xFFFFFFFF);
  static Color celadonTextColor = const Color(0xFF1F1F1F);
  static Color celadonWhiteTextColor = const Color(0xFFF6FAFF);


  static Color celadonWhiteCardColor = const Color(0xFFF9FAFB);
  static Color celadonGreyTextColor = const Color(0xFF60708F);

  //Cards colour
  static Color lightGreenCardColor = const Color(0xFFD4E4BF);
  static Color lightBlueCardColor = const Color(0xFFD7E5FF);
  static Color lightPinkCardColor = const Color(0xFFFFD4F2);
  static Color lightYellowCardColor = const Color(0xFFF3E4B9);

  //white Theme colours
  static Color whiteThemePrimaryColor = const Color(0xFF1B1A1B);
  static Color whiteThemeBackgroundColor = const Color(0xFFF3F3F9);
  static Color whiteThemeCardColor = const Color(0xFFFFFFFF);
  static Color whiteThemeTextColor = const Color(0xFF1B1A1B);

  //white Theme colours
  static Color darkThemePrimaryColor = const Color(0xFFD8E1E0);
  static Color darkThemeBackgroundColor = const Color(0xFF010101);
  static Color darkThemeCardColor = const Color(0xFF171717);
  static Color darkThemeTextColor = const Color(0xFFEBEBEB);

  //Button Gradient
  static Color blueButtonGradientColor = const Color(0xFF00649F);
  static Color orangeButtonGradientColor = const Color(0xFFF28A17);
  static Color pinkButtonGradientColor = const Color(0xFFBA2577);
  static Color purpleButtonGradientColor = const Color(0xFF7F0CA9);




}
