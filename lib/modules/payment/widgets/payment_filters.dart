import 'package:flutter/material.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../../widgets/app_dropdown_button.dart';
import '../../branch/widgets/branch_dropdown.dart';
import '../payment_controller.dart';

class PaymentFilters extends StatelessWidget {
  final _paymentController = getIt<PaymentController>();

  PaymentFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppDropdownButton(
          items: AppDateTime.generateYears(),
          streamDataSelected: _paymentController.selectedYear,
          onChanged: (newValue) => _paymentController.filterByYear(newValue!),
        ),
        AppDropdownButton(
          items: AppDateTime.generateAllMonths(),
          streamDataSelected: _paymentController.selectedMonth,
          onChanged: (newValue) => _paymentController.filterByMonth(newValue!),
        ),
        BranchDropdown(
          streamDataSelected: _paymentController.selectedBranch,
          onChanged: (newValue) => _paymentController.filterByBranch(newValue!),
        ),
      ],
    );
  }
}
