import 'package:flutter/material.dart';
import '../branch_controller.dart';
import '../branch.dart';
import '../../../setup/get_it_setup.dart';
import '../../../widgets/app_dropdown_button.dart';
import '../../../widgets/app_stream_builder.dart';

class BranchDropdown extends StatelessWidget {
  final Stream<Branch> streamDataSelected;
  final void Function(Branch?)? onChanged;

  final _controller = getIt<BranchController>();

  BranchDropdown({
    super.key,
    required this.streamDataSelected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Branch>>(
      stream: _controller.branches,
      onData: (branches) {
        // branches.add(Branch.all());

        return AppDropdownButton<Branch>(
          items: branches,
          streamDataSelected: streamDataSelected,
          onChanged: onChanged,
        );
      },
    );
  }
}
