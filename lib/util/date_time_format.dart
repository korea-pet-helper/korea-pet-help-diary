import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatString(DateTime dateTime) {
    final now = DateTime.now();

    final dif = now.difference(dateTime);

    if (dif.inMinutes < 10) {
      return '방금 전';
    } else if (dif.inMinutes < 60) {
      return '${dif.inMinutes}분 전';
    } else if (dif.inHours < 24) {
      return '${dif.inHours}분 전';
    } else {
      return DateFormat('M월 d일').format(dateTime);
    }
  }
}
