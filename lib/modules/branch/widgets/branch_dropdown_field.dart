import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../branch.dart';
import '../branch_controller.dart';

class BranchDropdownField extends StatefulWidget {
  final Function(Branch?) onChanged;
  final Branch? initialValue;
  final bool enabled;

  const BranchDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
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
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.$branches,
      getDisplayName: (a) => a.name,
      label: 'Sucursal',
    );
  }
}
