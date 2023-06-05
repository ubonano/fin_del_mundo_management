import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../employee.dart';
import '../employee_controller.dart';

class EmployeeDropdownField extends StatefulWidget {
  final Function(Employee?) onChanged;
  final Employee? initialValue;
  final bool enabled;

  const EmployeeDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  _EmployeeDropdownFieldState createState() => _EmployeeDropdownFieldState();
}

class _EmployeeDropdownFieldState extends State<EmployeeDropdownField> {
  final _controller = getIt<EmployeeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.employees,
      getDisplayName: (a) => a.name,
      label: 'Empleado',
    );
  }
}
