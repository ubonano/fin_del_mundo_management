import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../branch.dart';
import '../branch_controller.dart';
import '../../../setup/get_it_setup.dart';

class BranchDropdownField extends StatefulWidget {
  final Function(Branch?) onChanged;
  final Branch? initialValue;

  const BranchDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  _BranchDropdownFieldState createState() => _BranchDropdownFieldState();
}

class _BranchDropdownFieldState extends State<BranchDropdownField> {
  final _controller = getIt<BranchController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AppStreamBuilder(
        stream: _controller.branches,
        onData: (branches) => DropdownButtonFormField<Branch>(
          decoration: const InputDecoration(
            labelText: 'Sucursal',
            filled: true,
            isDense: true,
          ),
          value: widget.initialValue,
          validator: AppValidators.branch,
          items: _buildDropdownMenuItems(branches),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  List<DropdownMenuItem<Branch>> _buildDropdownMenuItems(
      List<Branch> branches) {
    return branches.map(
      (branch) {
        return DropdownMenuItem<Branch>(
          value: branch,
          child: Text(branch.name),
        );
      },
    ).toList();
  }
}
