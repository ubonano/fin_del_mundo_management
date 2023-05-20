import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../widgets/app_stream_builder.dart';

class DailyIncomeYearFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();
  final _logger = Logger('DailyIncomeYearFilter');

  DailyIncomeYearFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeYearFilter');

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildDropdown(),
          ],
        ),
      ),
    );
  }

  AppStreamBuilder<String> _buildDropdown() {
    _logger.info('Building Year Dropdown');

    return AppStreamBuilder<String>(
      stream: _controller.selectedYear,
      onData: (year) => DropdownButton<String>(
        value: year,
        onChanged: (newValue) => _onChanged(newValue),
        items: AppDateTime.generateYears()
            .map<DropdownMenuItem<String>>((value) => _yearDropdownItem(value))
            .toList(),
      ),
    );
  }

  void _onChanged(String? newValue) {
    _logger.info('Year changed: $newValue');

    if (newValue != null) {
      _controller.filterByYear(newValue);
    }
  }

  DropdownMenuItem<String> _yearDropdownItem(String value) {
    _logger.info('Generating Year Dropdown Item: $value');

    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
