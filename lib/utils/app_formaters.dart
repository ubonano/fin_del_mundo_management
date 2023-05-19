import 'package:intl/intl.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}

class AppFormaters {
  static String getFormattedDate(DateTime dateTime) {
    var formattedDate = DateFormat('EEEE dd', 'es_ES').format(dateTime);
    var day = formattedDate.split(' ')[0].inCaps;
    var date = formattedDate.split(' ').sublist(1).join(' ');

    return '$day $date';
  }

  static String getFormattedTotal(dynamic total) {
    final formatter = NumberFormat('#,###', 'es_AR');
    return formatter.format(total);
  }
}
