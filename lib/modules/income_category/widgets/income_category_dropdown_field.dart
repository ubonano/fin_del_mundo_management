import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../../branch/branch.dart';
import '../income_category.dart';
import '../income_category_controller.dart';

class IncomeCategoryDropdownField extends StatelessWidget {
  final Function(IncomeCategory?) onChanged;
  final IncomeCategory? initialValue;
  final Branch? branchFilter;
  final bool enabled;

  IncomeCategoryDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.branchFilter,
    this.enabled = true,
  });

  final _controller = getIt<IncomeCategoryController>();

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: onChanged,
      initialValue: initialValue,
      stream: _controller.$categories,
      getDisplayName: (a) => a.name,
      label: 'Categoria',
    );
  }
}
