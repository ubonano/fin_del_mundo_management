import 'package:fin_del_mundo_management/widgets/app_dropdown_field.dart';
import 'package:flutter/material.dart';
import '../../../setup/get_it_setup.dart';
import '../payment_method.dart';
import '../payment_method_controller.dart';

class PaymentMethodDropdownField extends StatefulWidget {
  final Function(PaymentMethod?) onChanged;
  final PaymentMethod? initialValue;
  final bool enabled;

  const PaymentMethodDropdownField({
    super.key,
    required this.onChanged,
    required this.initialValue,
    this.enabled = true,
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
    return AppDropdownField(
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      stream: _controller.paymentMethods,
      getDisplayName: (a) => a.name,
      label: 'Metodo de pago',
    );
  }
}
