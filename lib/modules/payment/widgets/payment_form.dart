import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/modules/payment_method/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../setup/get_it_setup.dart';
import '../../../widgets/app_form_field.dart';
import '../../../widgets/app_stream_builder.dart';
import '../../branch/branch.dart';
import '../../payment/payment.dart';
import '../../payment/payment_controller.dart';
import '../../branch/widgets/branch_dropdown_field.dart';
import '../../payment_category/payment_category.dart';
import '../../payment_category/payment_category_controller.dart';
import '../../payment_category/widgets/payment_category_dropdown_field.dart';
import '../../payment_method/widgets/payment_method_dropdown_field.dart';

class PaymentForm extends StatefulWidget {
  final Payment? payment;

  const PaymentForm({Key? key, this.payment}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StackRouter get router => AutoRouter.of(context);

  final _paymentController = getIt<PaymentController>();

  late final TextEditingController _dateController;
  late Branch? _branch;
  late final TextEditingController _beneficiaryIdController;
  late final TextEditingController _statusController;
  late final TextEditingController _paymentDateController;
  late final TextEditingController _totalController;
  late PaymentCategory? _category;
  late PaymentMethod? _method;

  late bool _paymentDateFieldEnabled;
  late bool _methodFieldEnabled;

  @override
  void initState() {
    super.initState();

    _dateController = TextEditingController(
        text: widget.payment?.date != null
            ? DateFormat('yyyy-MM-dd').format(widget.payment!.date)
            : '');
    _beneficiaryIdController =
        TextEditingController(text: widget.payment?.beneficiaryId ?? '');
    _statusController =
        TextEditingController(text: widget.payment?.status ?? '');
    _paymentDateController = TextEditingController(
        text: widget.payment?.paymentDate != null
            ? DateFormat('yyyy-MM-dd').format(widget.payment!.paymentDate)
            : '');
    _totalController =
        TextEditingController(text: widget.payment?.total.toString() ?? '0');
    _category = widget.payment?.category;

    _paymentDateFieldEnabled = widget.payment?.status == "Pagado";
    _methodFieldEnabled = widget.payment?.status == "Pagado";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Row(
            children: [
              _dateField(),
              const SizedBox(width: 20),
              _branchField(),
              const SizedBox(width: 20),
              _totalField(),
            ],
          ),
          Row(
            children: [
              _paymentCategoryField(),
              const SizedBox(width: 20),
              _beneficiaryIdField(),
            ],
          ),
          Row(
            children: [
              _statusField(),
              const SizedBox(width: 20),
              _paymentDateField(),
              const SizedBox(width: 20),
              _methodField(),
            ],
          ),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _dateField() {
    return Expanded(
      child: AppFormField.date(
        labelText: 'Fecha',
        required: true,
        controller: _dateController,
        onFieldSubmitted: (value) => _submit(),
      ),
    );
  }

  Widget _branchField() {
    return Expanded(
      child: BranchDropdownField(
        initialValue: widget.payment?.branch,
        onChanged: (value) {
          _branch = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _beneficiaryIdField() {
    return Expanded(
      child: AppFormField.text(
        labelText: 'ID del beneficiario',
        required: true,
        controller: _beneficiaryIdController,
        onFieldSubmitted: (value) => _submit(),
      ),
    );
  }

  Widget _statusField() {
    return Expanded(
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Estado',
        ),
        value: _statusController.text.isEmpty
            ? 'Pendiente'
            : _statusController.text,
        items: const <String>['Pendiente', 'Pagado'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          _statusController.text = value!;
          _paymentDateFieldEnabled = value == "Pagado";
          _methodFieldEnabled = value == "Pagado";
          setState(() {});
        },
      ),
    );
  }

  Widget _paymentDateField() {
    return Expanded(
      child: AppFormField.date(
        labelText: 'Fecha de Pago',
        required: _paymentDateFieldEnabled,
        enabled: _paymentDateFieldEnabled,
        controller: _paymentDateController,
        onFieldSubmitted: (value) => _submit(),
      ),
    );
  }

  Widget _methodField() {
    return Expanded(
      child: PaymentMethodDropdownField(
        initialValue: widget.payment?.method,
        onChanged: (value) {
          _method = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _paymentCategoryField() {
    return Expanded(
      child: PaymentCategoryDropdownField(
        initialValue: widget.payment?.category,
        onChanged: (value) {
          _category = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _totalField() {
    return Expanded(
      child: AppFormField.number(
        labelText: 'Total',
        enabled: false,
        controller: _totalController,
      ),
    );
  }

  ElevatedButton _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      child: const Text('Enviar'),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final payment = _getPaymentToSave();

        if (widget.payment == null) {
          await _paymentController.add(payment);
        } else {
          await _paymentController.update(payment);
        }
        _showSnackbar('Pago guardado');

        router.pop();
      } catch (e) {
        _showSnackbar('Ocurrió un error: $e');
      }
    }
  }

  Payment _getPaymentToSave() {
    return Payment(
      id: widget.payment?.id ?? '',
      date: DateTime.parse(_dateController.text),
      beneficiaryId: _beneficiaryIdController.text,
      status: _statusController.text,
      paymentDate: DateTime.parse(_paymentDateController.text),
      category: _category!,
      total: double.parse(_totalController.text),
      branch: _branch!,
      method: _method!,
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _beneficiaryIdController.dispose();
    _statusController.dispose();
    _paymentDateController.dispose();
    _totalController.dispose();

    super.dispose();
  }
}
