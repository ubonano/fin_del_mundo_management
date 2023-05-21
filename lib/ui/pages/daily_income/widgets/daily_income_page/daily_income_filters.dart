import 'package:flutter/material.dart';

import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../widgets/app_dropdown_button.dart';

class DailyIncomeFilters extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDropdownButton(
          items: AppDateTime.generateYears(),
          streamData: _controller.selectedYear,
          onChanged: (newValue) => _controller.filterByYear(newValue!),
        ),
        AppDropdownButton(
          items: AppDateTime.generateAllMonths(),
          streamData: _controller.selectedMonth,
          onChanged: (newValue) => _controller.filterByMonth(newValue!),
        ),
        AppDropdownButton(
          items: const <String>['All', 'Restaurante', 'Discoteca'],
          streamData: _controller.selectedBranch,
          onChanged: (newValue) => _controller.filterByBranch(newValue!),
        ),
      ],
    );
  }
}
