import 'package:flutter/material.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../../widgets/app_dropdown_button.dart';
import '../../branch/widgets/branch_dropdown.dart';
import '../income_controller.dart';

class IncomeFilters extends StatelessWidget {
  final _incomeController = getIt<IncomeController>();

  IncomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDropdownButton(
          items: AppDateTime.generateYears(),
          streamDataSelected: _incomeController.selectedYear,
          onChanged: (newValue) => _incomeController.filterByYear(newValue!),
        ),
        AppDropdownButton(
          items: AppDateTime.generateAllMonths(),
          streamDataSelected: _incomeController.selectedMonth,
          onChanged: (newValue) => _incomeController.filterByMonth(newValue!),
        ),
        BranchDropdown(
          streamDataSelected: _incomeController.selectedBranch,
          onChanged: (newValue) => _incomeController.filterByBranch(newValue!),
        ),
      ],
    );
  }
}
