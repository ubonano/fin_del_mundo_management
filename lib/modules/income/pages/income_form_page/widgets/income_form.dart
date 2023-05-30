import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../widgets/app_form_field.dart';
import '../../../../branch/branch.dart';
import '../../../../branch/widgets/app_branch_field.dart';
import '../../../../user/user.dart';
import '../../../income.dart';
import '../../../income_controller.dart';

class IncomeForm extends StatefulWidget {
  final Income? income;

  const IncomeForm({Key? key, this.income}) : super(key: key);

  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StackRouter get router => AutoRouter.of(context);

  final _controller = getIt<IncomeController>();

  late final TextEditingController _dateController = TextEditingController(
      text: widget.income?.date != null
          ? DateFormat('yyyy-MM-dd').format(widget.income!.date)
          : '');
  late Branch? _branch = widget.income?.branch;
  late final TextEditingController _cashController = TextEditingController(
      text: widget.income?.collectionMethods['cash'].toString() ?? '');
  late final TextEditingController _cardsController = TextEditingController(
      text: widget.income?.collectionMethods['cards'].toString() ?? '');
  late final TextEditingController _mercadoPagoController =
      TextEditingController(
          text:
              widget.income?.collectionMethods['mercadoPago'].toString() ?? '');
  late final TextEditingController _totalController =
      TextEditingController(text: widget.income?.total.toString() ?? '0');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Row(
            children: [
              _dateField(),
              const SizedBox(width: 20),
              _branchField(),
            ],
          ),
          _cashField(),
          _cardsField(),
          _mpField(),
          _totalField(),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: _submit,
      child: const Text('Enviar'),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final income = _getDailyIncomeToSave();

        if (widget.income == null) {
          await _controller.add(income);
          _showSnackbar('Ingreso diario guardado');
        } else {
          await _controller.update(income);
          _showSnackbar('Ingreso diario actualizado');
        }

        router.pop();
      } catch (e) {
        _showSnackbar('Ocurrio un error: $e');
      }
    }
  }

  Income _getDailyIncomeToSave() {
    return Income(
      id: widget.income?.id ?? '',
      createdAt: widget.income?.createdAt ?? DateTime.now(),
      createdBy: User(id: 'system', name: 'system'),
      modifiedAt: DateTime.now(),
      modifiedBy: User(id: 'system', name: 'system'),
      date: DateTime.parse(_dateController.text),
      branch: _branch!,
      total: widget.income?.total ?? 0.0,
      collectionMethods: {
        'cash': double.parse(_cashController.text),
        'cards': double.parse(_cardsController.text),
        'mercadoPago': double.parse(_mercadoPagoController.text),
      },
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
      child: AppBranchField(
        initialValue: widget.income?.branch,
        onChanged: (value) {
          _branch = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _cashField() {
    return AppFormField.number(
      labelText: 'Efectivo',
      required: true,
      controller: _cashController,
      onFieldSubmitted: (value) => _submit(),
      onChanged: (value) => _updateTotal(),
    );
  }

  Widget _cardsField() {
    return AppFormField.number(
      labelText: 'Tarjetas',
      required: true,
      controller: _cardsController,
      onFieldSubmitted: (value) => _submit(),
      onChanged: (value) => _updateTotal(),
    );
  }

  Widget _mpField() {
    return AppFormField.number(
      labelText: 'Mercado Pago',
      required: true,
      controller: _mercadoPagoController,
      onFieldSubmitted: (value) => _submit(),
      onChanged: (value) => _updateTotal(),
    );
  }

  void _updateTotal() {
    double total = _calculateTotal();
    _totalController.text = total.toString();
  }

  double _calculateTotal() {
    double cash = double.tryParse(_cashController.text) ?? 0;
    double cards = double.tryParse(_cardsController.text) ?? 0;
    double mercadoPago = double.tryParse(_mercadoPagoController.text) ?? 0;

    return cash + cards + mercadoPago;
  }

  Widget _totalField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: AppFormField.number(
        labelText: 'Total',
        enabled: false,
        controller: _totalController,
      ),
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
    _cashController.dispose();
    _cardsController.dispose();
    _mercadoPagoController.dispose();
    _totalController.dispose();
    super.dispose();
  }
}
