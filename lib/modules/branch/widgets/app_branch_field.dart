import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../branch.dart';
import '../branch_controller.dart';
import '../../../setup/get_it_setup.dart';

class AppBranchField extends StatefulWidget {
  final Function(Branch?) onChanged;
  final Branch? initialValue;

  const AppBranchField({
    super.key,
    required this.onChanged,
    this.initialValue,
  });

  @override
  _AppBranchFieldState createState() => _AppBranchFieldState();
}

class _AppBranchFieldState extends State<AppBranchField> {
  final _controller = getIt<BranchController>();

  Branch? _selectedBranch;

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
          value: _selectedBranch,
          validator: AppValidators.branch,
          items: _buildDropdownMenuItems(branches),
          onChanged: _onChanged,
        ),
      ),
    );
  }

  void _onChanged(Branch? branch) {
    widget.onChanged(branch);
    setState(() {
      _selectedBranch = branch;
    });
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
