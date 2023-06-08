import 'package:flutter/material.dart';
import '../branch_controller.dart';
import '../branch.dart';
import '../../../setup/get_it_setup.dart';
import '../../../widgets/app_dropdown_button.dart';

class BranchDropdown extends StatelessWidget {
  final Stream<Branch> $branchSelected;
  final void Function(Branch?) onChanged;

  final _controller = getIt<BranchController>();

  BranchDropdown({
    super.key,
    required this.$branchSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdownButton<Branch>(
      itemsStream: _controller.$branches,
      itemSelectedStrem: $branchSelected,
      onChanged: onChanged,
    );
  }
}
