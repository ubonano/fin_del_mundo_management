import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_form_fields.dart';

class DailyIncomeForm extends StatefulWidget {
  const DailyIncomeForm({Key? key}) : super(key: key);

  @override
  _DailyIncomeFormState createState() => _DailyIncomeFormState();
}

class _DailyIncomeFormState extends State<DailyIncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controller = getIt<DailyIncomeController>();

  late final StackRouter? router;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _cashController = TextEditingController();
  final TextEditingController _cardsController = TextEditingController();
  final TextEditingController _mercadoPagoController = TextEditingController();
  final TextEditingController _surplusController = TextEditingController();
  final TextEditingController _shortageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          AppFormFields.date(
            labelText: 'Fecha',
            required: true,
            controller: _dateController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.text(
            labelText: 'Sucursal',
            required: true,
            controller: _branchController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.number(
            labelText: 'Efectivo',
            required: true,
            controller: _cashController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.number(
            labelText: 'Tarjetas',
            required: true,
            controller: _cardsController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.number(
            labelText: 'Mercado Pago',
            required: true,
            controller: _mercadoPagoController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.number(
            labelText: 'Sobrante',
            controller: _surplusController,
            onFieldSubmitted: (value) => _submit(),
          ),
          AppFormFields.number(
            labelText: 'Faltante',
            controller: _shortageController,
            onFieldSubmitted: (value) => _submit(),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      try {
        _controller.add(
          DailyIncome(
            modifiedAt: DateTime.now(),
            createdAt: DateTime.now(),
            date: DateTime.parse(_dateController.text),
            branch: _branchController.text,
            paymentMethods: {
              'cash': double.parse(_cashController.text),
              'cards': double.parse(_cardsController.text),
              'mercadoPago': double.parse(_mercadoPagoController.text),
            },
            surplus: double.parse(_surplusController.text),
            shortage: double.parse(_shortageController.text),
          ),
        );

        _showSnackbar('Ingreso diario guardado');

        router?.pop();
      } catch (e) {
        _showSnackbar('Ocurrio un error');
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _branchController.dispose();
    _cashController.dispose();
    _cardsController.dispose();
    _mercadoPagoController.dispose();
    _surplusController.dispose();
    _shortageController.dispose();
    super.dispose();
  }
}
