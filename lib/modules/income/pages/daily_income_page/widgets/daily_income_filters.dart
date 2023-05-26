import 'package:flutter/material.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../../widgets/app_dropdown_button.dart';
import '../../../../branch/widgets/branch_dropdown.dart';
import '../../../income_controller.dart';

class DailyIncomeFilters extends StatelessWidget {
  final _dailyIncomeController = getIt<IncomeController>();

  DailyIncomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDropdownButton(
          items: AppDateTime.generateYears(),
          streamDataSelected: _dailyIncomeController.selectedYear,
          onChanged: (newValue) =>
              _dailyIncomeController.filterByYear(newValue!),
        ),
        AppDropdownButton(
          items: AppDateTime.generateAllMonths(),
          streamDataSelected: _dailyIncomeController.selectedMonth,
          onChanged: (newValue) =>
              _dailyIncomeController.filterByMonth(newValue!),
        ),
        BranchDropdown(
          streamDataSelected: _dailyIncomeController.selectedBranch,
          onChanged: (newValue) =>
              _dailyIncomeController.filterByBranch(newValue!),
        ),
      ],
    );
  }
}
