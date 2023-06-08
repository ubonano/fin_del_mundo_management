import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../income_method.dart';
import '../income_method_controller.dart';

class IncomeMethodDropdownField extends StatelessWidget {
  final Function(IncomeMethod?) onChanged;
  final IncomeMethod? initialValue;
  final bool enabled;

  IncomeMethodDropdownField({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.enabled = true,
  });

  final _controller = getIt<IncomeMethodController>();

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: onChanged,
      initialValue: initialValue,
      stream: _controller.$incomeMethods,
      getDisplayName: (a) => a.name,
      label: 'Metodo',
    );
  }
}
