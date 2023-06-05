import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/modules/payment_method/payment_method.dart';
import 'package:fin_del_mundo_management/modules/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../setup/get_it_setup.dart';
import '../../../widgets/app_form_field.dart';
import '../../branch/branch.dart';
import '../../employee/employee.dart';
import '../../employee/widgets/employee_dropdown_field.dart';
import '../../payment/payment.dart';
import '../../payment/payment_controller.dart';
import '../../branch/widgets/branch_dropdown_field.dart';
import '../../payment_category/payment_category.dart';
import '../../payment_category/widgets/payment_category_dropdown_field.dart';
import '../../payment_method/widgets/payment_method_dropdown_field.dart';
import '../../provider/widgets/provider_dropdown_field.dart';

enum PaymentStatus { pending, paid }

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
  late PaymentStatus _paymentStatus;
  late final TextEditingController _paymentDateController;
  late final TextEditingController _totalController;
  late PaymentCategory? _category;
  late PaymentMethod? _method;
  late Employee? _employee;
  late Provider? _provider;

  late bool _paymentDateFieldEnabled;
  late bool _methodFieldEnabled;

  @override
  void initState() {
    super.initState();

    _dateController = TextEditingController(
        text: widget.payment?.date != null
            ? DateFormat('yyyy-MM-dd').format(widget.payment!.date)
            : '');

    _paymentStatus = widget.payment?.status == "Pagado"
        ? PaymentStatus.paid
        : PaymentStatus.pending;

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
              _category?.name == 'Empleados'
                  ? _employeeField()
                  : _category?.name == 'Proveedores'
                      ? _providerField()
                      : Container(),
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

  Widget _statusField() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Estado'),
          RadioListTile<PaymentStatus>(
            title: const Text('Pendiente'),
            value: PaymentStatus.pending,
            groupValue: _paymentStatus,
            onChanged: (PaymentStatus? value) {
              setState(() {
                _paymentStatus = value!;
                _paymentDateFieldEnabled = value == PaymentStatus.paid;
                _methodFieldEnabled = value == PaymentStatus.paid;
              });
            },
          ),
          RadioListTile<PaymentStatus>(
            title: const Text('Pagado'),
            value: PaymentStatus.paid,
            groupValue: _paymentStatus,
            onChanged: (PaymentStatus? value) {
              setState(() {
                _paymentStatus = value!;
                _paymentDateFieldEnabled = value == PaymentStatus.paid;
                _methodFieldEnabled = value == PaymentStatus.paid;
              });
            },
          ),
        ],
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
        enabled: _methodFieldEnabled,
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

  Widget _employeeField() {
    return Expanded(
      child: EmployeeDropdownField(
        initialValue: widget.payment != null
            ? Employee(
                id: widget.payment!.beneficiaryId,
                name: widget.payment!.beneficiaryName,
              )
            : null,
        onChanged: (value) {
          _employee = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _providerField() {
    return Expanded(
      child: ProviderDropdownField(
        initialValue: widget.payment != null
            ? Provider(
                id: widget.payment!.beneficiaryId,
                name: widget.payment!.beneficiaryName,
              )
            : null,
        onChanged: (value) {
          _provider = value;
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
      beneficiaryId: _category?.name == "Empleados"
          ? _employee?.id ?? ''
          : _category?.name == "Proveedores"
              ? _provider?.id ?? ''
              : '',
      beneficiaryName: _category?.name == "Empleados"
          ? _employee?.name ?? ''
          : _category?.name == "Proveedores"
              ? _provider?.name ?? ''
              : "",
      status: _paymentStatus == PaymentStatus.paid ? 'Pagado' : 'Pendiente',
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
    _paymentDateController.dispose();
    _totalController.dispose();

    super.dispose();
  }
}
