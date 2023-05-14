import 'package:flutter/material.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeYearFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeYearFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Año'),
            const SizedBox(width: 10),
            AppStreamBuilder<String>(
              stream: _controller.selectedYear,
              onData: (year) {
                return DropdownButton<String>(
                  value: year,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _controller.filterByYear(newValue);
                    }
                  },
                  items: _generateYears().map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<String> _generateYears() {
    final currentYear = DateTime.now().year;
    return List<String>.generate(
      11,
      (index) => (currentYear - 5 + index).toString(),
    );
  }
}
