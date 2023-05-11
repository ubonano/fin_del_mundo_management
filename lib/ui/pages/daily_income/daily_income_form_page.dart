import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/utils/app_validators.dart';
import 'package:flutter/material.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_form_fields.dart';

@RoutePage()
class DailyIncomeFormPage extends StatefulWidget {
  const DailyIncomeFormPage({Key? key}) : super(key: key);

  @override
  _DailyIncomeFormPageState createState() => _DailyIncomeFormPageState();
}

class _DailyIncomeFormPageState extends State<DailyIncomeFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final StackRouter? router;

  final _controller = getIt<DailyIncomeController>();

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Income Form'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            AppFormFields.date(
                controller: _dateController,
                labelText: 'Fecha',
                onFieldSubmitted: (value) => _submit(),
                validator: AppValidators.date),
            AppFormFields.text(
              labelText: 'Sucursal',
              controller: _branchController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            AppFormFields.number(
              labelText: 'Efectivo',
              controller: _cashController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            AppFormFields.number(
              labelText: 'Tarjetas',
              controller: _cardsController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            AppFormFields.number(
              labelText: 'MercadoPago',
              controller: _mercadoPagoController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            AppFormFields.number(
              labelText: 'Sobrante',
              controller: _surplusController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            AppFormFields.number(
              labelText: 'Faltante',
              controller: _shortageController,
              onFieldSubmitted: (value) => _submit(),
              // validator: AppValidators.password,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Submit'),
            ),
          ],
        ),
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
        _showSnackbar('Ingreso diario guardado!');

        router?.pop();
      } catch (e) {
        _showSnackbar('Error writing order: $e');
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
