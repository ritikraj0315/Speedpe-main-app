import 'package:intl/intl.dart';

class DateAndTimeHelper {

  static String formatRelativeTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime; // output - 15:25
  }


}
