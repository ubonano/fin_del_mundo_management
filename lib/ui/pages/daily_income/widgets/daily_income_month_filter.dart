import 'package:flutter/material.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeMonthFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeMonthFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final months = _controller.generateAllMonths();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Mes'),
            const SizedBox(width: 10),
            AppStreamBuilder<String>(
              stream: _controller.selectedMonth,
              onData: (month) {
                return DropdownButton<String>(
                  value: month,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _controller.filterByMonth(newValue);
                    }
                  },
                  items: months.map<DropdownMenuItem<String>>(
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
}
