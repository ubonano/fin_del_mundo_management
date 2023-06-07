import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../payment_category.dart';
import '../payment_category_controller.dart';

class PaymentCategoryDropdownField extends StatefulWidget {
  final Function(PaymentCategory?) onChanged;
  final PaymentCategory? initialValue;
  final bool enabled;

  const PaymentCategoryDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
  });

  @override
  _PaymentCategoryDropdownFieldState createState() =>
      _PaymentCategoryDropdownFieldState();
}

class _PaymentCategoryDropdownFieldState
    extends State<PaymentCategoryDropdownField> {
  final _controller = getIt<PaymentCategoryController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.$paymentCategories,
      getDisplayName: (a) => a.name,
      label: 'Categoria de pago',
    );
  }
}
