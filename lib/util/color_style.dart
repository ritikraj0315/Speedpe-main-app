import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:six_cash/util/color_resources.dart';

class ColorStyle {
  static const _defaultTextStyle = TextStyle(fontWeight: FontWeight.w500);

  ThemeData themeData(int index, BuildContext context) {
    switch (index) {
      case 0:
        return setWhiteTheme(context);
      case 1:
        return setBlackTheme(context);
      case 2:
        return setLimeTheme(context);
      case 3:
        return setPurpleTheme(context);
      case 4:
        return setOrangeTheme(context);
      default:
        return setBlackTheme(context);
    }
  }

  Future<void> _saveNumber(int indexNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', indexNumber);
  }

  ThemeData setWhiteTheme(BuildContext context) {
    _saveNumber(0);
    return ThemeData(
      // primarySwatch: Colors.white,
      primaryColor: ColorResources.blueColor,
      backgroundColor: ColorResources.whiteThemeBackgroundColor,
      indicatorColor: ColorResources.whiteThemeTextColor,
      hintColor: ColorResources.whiteThemeTextColor.withOpacity(0.5),
      errorColor: ColorResources.lightRedColor,
      highlightColor: ColorResources.whiteThemeTextColor,
      focusColor: ColorResources.whiteThemeTextColor,
      disabledColor: ColorResources.lightRedColor,
      cardColor: ColorResources.whiteThemeCardColor,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
    );
  }

  ThemeData setBlackTheme(BuildContext context) {
    _saveNumber(1);
    return ThemeData(
      // primarySwatch: Colors.black,
      primaryColor: ColorResources.blueColor,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ColorResources.blueColor,
          onPrimary: ColorResources.blueColor,
          secondary: ColorResources.blueColor,
          onSecondary: ColorResources.blueColor,
          error: Colors.red.shade900,
          onError: Colors.red.shade900,
          background: ColorResources.darkThemeBackgroundColor,
          onBackground: ColorResources.darkThemeBackgroundColor,
          surface: ColorResources.darkThemeBackgroundColor,
          onSurface: ColorResources.darkThemeBackgroundColor),
      indicatorColor: Colors.white,
      hintColor: Colors.grey.shade500,
      errorColor: Colors.red.shade900,
      highlightColor: Colors.grey.shade700,
      focusColor: ColorResources.darkThemeTextColor,
      disabledColor: Colors.grey.shade800,
      cardColor: ColorResources.darkThemeCardColor,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.dark()),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        elevation: 0,
      ),
    );
  }

  ThemeData setLimeTheme(BuildContext context) {
    _saveNumber(2);
    return ThemeData(
      // primarySwatch: Colors.black,
      primaryColor: ColorResources.limeColor.withOpacity(0.7),
      backgroundColor: ColorResources.blackColor,
      indicatorColor: Colors.white,
      hintColor: Colors.grey.shade500,
      errorColor: Colors.red.shade900,
      highlightColor: Colors.grey.shade700,
      focusColor: Colors.white,
      disabledColor: Colors.grey.shade800,
      cardColor: ColorResources.darkGrayColor,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.dark()),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        elevation: 0,
      ),
    );
  }

  ThemeData setPurpleTheme(BuildContext context) {
    _saveNumber(3);
    return ThemeData(
      // primarySwatch: Colors.black,
      primaryColor: ColorResources.purpleColor,
      backgroundColor: ColorResources.lightPurpleColor,
      indicatorColor: ColorResources.whiteColor,
      hintColor: Colors.grey.shade500,
      errorColor: Colors.red.shade900,
      highlightColor: ColorResources.purpleColor,
      focusColor: Colors.black,
      disabledColor: Colors.grey.shade800,
      cardColor: ColorResources.whiteColor,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.dark()),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        elevation: 0,
      ),
    );
  }

  ThemeData setOrangeTheme(BuildContext context) {
    _saveNumber(4);
    return ThemeData(
      // primarySwatch: Colors.black,
      primaryColor: ColorResources.orangeColor,
      backgroundColor: ColorResources.darkOrangeColor,
      indicatorColor: Colors.white,
      hintColor: Colors.grey.shade500,
      errorColor: Colors.red.shade900,
      highlightColor: Colors.white,
      focusColor: Colors.white,
      disabledColor: Colors.grey.shade800,
      cardColor: ColorResources.lightOrangeColor,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.dark()),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        elevation: 0,
      ),
    );
  }

  ThemeData setOtherTheme(
      {required BuildContext context,
      required Color mColor,
      required Color color}) {
    return ThemeData(
      //primarySwatch: mColor,
      primaryColor: mColor,
      backgroundColor: Colors.white,
      indicatorColor: mColor,
      hintColor: Colors.grey.shade500,
      errorColor: Colors.red.shade900,
      highlightColor: Colors.grey.shade200,
      focusColor: color,
      disabledColor: Colors.grey.shade300,
      cardColor: Colors.grey.shade100,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        backgroundColor: mColor,
        elevation: 0,
      ),
    );
  }

  ThemeData setOtherThemeColor(
      {required BuildContext context,
      required MaterialColor mColor,
      required Color color}) {
    return ThemeData(
      primarySwatch: mColor,
      primaryColor: mColor,
      backgroundColor: Colors.white,
      indicatorColor: mColor,
      hintColor: mColor.shade200,
      errorColor: mColor.shade500,
      highlightColor: Colors.grey.shade200,
      focusColor: color,
      disabledColor: Colors.grey.shade300,
      cardColor: Colors.grey.shade100,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        backgroundColor: mColor,
        elevation: 0,
      ),
    );
  }

  static TextTheme textTheme(BuildContext context) {
    return TextTheme(
      headline1: _defaultTextStyle.copyWith(
          fontSize: 100,
          color: Theme.of(context).indicatorColor,
          fontWeight: FontWeight.w200),
      headline2: _defaultTextStyle.copyWith(
          fontSize: 25, color: Theme.of(context).indicatorColor),
      headline3: _defaultTextStyle.copyWith(
          fontSize: 16, color: Theme.of(context).indicatorColor),
      headline4: _defaultTextStyle.copyWith(
          fontSize: 18, color: Theme.of(context).indicatorColor),
      headline5: _defaultTextStyle.copyWith(
          fontSize: 14, color: Theme.of(context).indicatorColor),
      bodyText1: _defaultTextStyle.copyWith(
          fontSize: 13, color: Theme.of(context).indicatorColor),
      bodyText2: _defaultTextStyle.copyWith(
          fontSize: 20, color: Theme.of(context).indicatorColor),
      subtitle1: _defaultTextStyle.copyWith(
          fontSize: 12, color: Theme.of(context).hintColor),
      subtitle2: _defaultTextStyle.copyWith(
          fontSize: 10, color: Theme.of(context).hintColor),
    );
  }
}
