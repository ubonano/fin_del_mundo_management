import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../widgets/app_stream_builder.dart';

class DailyIncomeMonthFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();
  final _logger = Logger('DailyIncomeMonthFilter');

  DailyIncomeMonthFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeMonthFilter');
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            AppStreamBuilder<String>(
              stream: _controller.selectedMonth,
              onData: (month) => _buildDropdownButton(month),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _buildDropdownButton(String month) {
    _logger.info('Building DropdownButton with month: $month');
    return DropdownButton<String>(
      value: month,
      onChanged: (String? newValue) {
        if (newValue != null) {
          _controller.filterByMonth(newValue);
          _logger.info('FilterByMonth changed to: $newValue');
        }
      },
      items: AppDateTime.generateAllMonths()
          .map<DropdownMenuItem<String>>(
              (String value) => _buildDropdownMenuItem(value))
          .toList(),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    _logger.info('Building DropdownMenuItem with value: $value');
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
