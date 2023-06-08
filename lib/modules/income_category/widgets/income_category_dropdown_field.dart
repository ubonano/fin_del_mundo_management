import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../income_category.dart';
import '../income_category_controller.dart';

class IncomeCategoryDropdownField extends StatefulWidget {
  final Function(IncomeCategory?) onChanged;
  final IncomeCategory? initialValue;
  final bool enabled;

  const IncomeCategoryDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  _IncomeCategoryDropdownFieldState createState() =>
      _IncomeCategoryDropdownFieldState();
}

class _IncomeCategoryDropdownFieldState
    extends State<IncomeCategoryDropdownField> {
  final _controller = getIt<IncomeCategoryController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.$incomeCategories,
      getDisplayName: (a) => a.name,
      label: 'Categoria',
    );
  }
}
