import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../payment_method.dart';
import '../payment_method_controller.dart';

class PaymentMethodDropdownField extends StatefulWidget {
  final Function(PaymentMethod?) onChanged;
  final PaymentMethod? initialValue;

  const PaymentMethodDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  _PaymentMethodDropdownFieldState createState() =>
      _PaymentMethodDropdownFieldState();
}

class _PaymentMethodDropdownFieldState
    extends State<PaymentMethodDropdownField> {
  final _controller = getIt<PaymentMethodController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: AppStreamBuilder(
        stream: _controller.paymentMethods,
        onData: (branches) => DropdownButtonFormField<PaymentMethod>(
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

  List<DropdownMenuItem<PaymentMethod>> _buildDropdownMenuItems(
      List<PaymentMethod> branches) {
    return branches.map(
      (branch) {
        return DropdownMenuItem<PaymentMethod>(
          value: branch,
          child: Text(branch.name),
        );
      },
    ).toList();
  }
}
