import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../utils/app_date_time.dart';
import '../../../widgets/app_stream_builder.dart';

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
            const Text('Año'),
            const SizedBox(width: 10),
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
      onData: (year) => _dropdown(year),
    );
  }

  DropdownButton<String> _dropdown(String year) {
    _logger.info('Building Year Dropdown Button');

    return DropdownButton<String>(
      value: year,
      onChanged: (newValue) => _onChanged(newValue),
      items: _yearItems(),
    );
  }

  void _onChanged(String? newValue) {
    _logger.info('Year changed: $newValue');

    if (newValue != null) {
      _controller.filterByYear(newValue);
    }
  }

  List<DropdownMenuItem<String>> _yearItems() {
    _logger.info('Generating Year Dropdown Items');

    return AppDateTime.generateYears()
        .map<DropdownMenuItem<String>>(
          (value) => _yearDropdownItem(value),
        )
        .toList();
  }

  DropdownMenuItem<String> _yearDropdownItem(String value) {
    _logger.info('Generating Year Dropdown Item: $value');

    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
