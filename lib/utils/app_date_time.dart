import 'package:intl/intl.dart';

class AppDateTime {
  static int monthNameToNumber(String monthName) {
    const monthNames = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    // +1 porque los índices de las listas empiezan en 0, pero los meses en 1.
    return monthNames.indexOf(monthName) + 1;
  }

  static String currentMonth() {
    DateTime now = DateTime.now();
    return DateFormat.MMMM('es_ES').format(now);
  }

  static List<String> generateAllMonths() {
    final months = <String>[];

    for (int i = 1; i <= 12; i++) {
      final date = DateTime(DateTime.now().year, i);
      final monthName = DateFormat.MMMM('es_ES').format(date);
      months.add(monthName);
    }

    return months;
  }
}
