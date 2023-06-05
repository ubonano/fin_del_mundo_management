import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../payment_category.dart';
import '../payment_category_controller.dart';

class PaymentCategoryDropdownField extends StatefulWidget {
  final Function(PaymentCategory?) onChanged;
  final PaymentCategory? initialValue;

  const PaymentCategoryDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AppStreamBuilder(
        stream: _controller.paymentCategories,
        onData: (branches) => DropdownButtonFormField<PaymentCategory>(
          decoration: const InputDecoration(
            labelText: 'Categoria',
            filled: true,
            isDense: true,
          ),
          value: widget.initialValue,
          validator: AppValidators.object,
          items: _buildDropdownMenuItems(branches),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }

  List<DropdownMenuItem<PaymentCategory>> _buildDropdownMenuItems(
      List<PaymentCategory> branches) {
    return branches.map(
      (branch) {
        return DropdownMenuItem<PaymentCategory>(
          value: branch,
          child: Text(branch.name),
        );
      },
    ).toList();
  }
}
