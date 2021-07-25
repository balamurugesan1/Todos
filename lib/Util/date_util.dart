import 'package:intl/intl.dart';

class DateUtil {
  static const DATE = "dd-MM-yyyy";

  String formattedDate(DateTime dateTime) {
    return DateFormat(DATE).format(dateTime);
  }
}
