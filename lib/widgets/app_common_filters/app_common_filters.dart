import 'package:flutter/material.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../widgets/app_dropdown_button.dart';
import '../../modules/branch/widgets/branch_dropdown.dart';
import 'common_filters_controller.dart';

class AppCommonFilters extends StatelessWidget {
  final _controller = getIt<CommonFiltersController>();

  AppCommonFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDropdownButton(
          itemsStream: _controller.$years,
          itemSelectedStrem: _controller.$selectedYear,
          onChanged: (year) => _controller.filterByYear(year!),
        ),
        AppDropdownButton(
          itemsStream: _controller.$months,
          itemSelectedStrem: _controller.$selectedMonth,
          onChanged: (month) => _controller.filterByMonth(month!),
        ),
        BranchDropdown(
          streamDataSelected: _controller.$selectedBranch,
          onChanged: (branch) => _controller.filterByBranch(branch!),
        ),
      ],
    );
  }
}
