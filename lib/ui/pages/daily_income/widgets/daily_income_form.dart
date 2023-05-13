import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_form_fields.dart';
import 'branch_field.dart';

class DailyIncomeForm extends StatefulWidget {
  final DailyIncome? income;

  const DailyIncomeForm({Key? key, this.income}) : super(key: key);

  @override
  _DailyIncomeFormState createState() => _DailyIncomeFormState();
}

class _DailyIncomeFormState extends State<DailyIncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _logger = Logger('DailyIncomeForm');
  late StackRouter? router;
  final _controller = getIt<DailyIncomeController>();

  late final TextEditingController _dateController = TextEditingController(
      text: widget.income?.date != null
          ? DateFormat('yyyy-MM-dd').format(widget.income!.date)
          : '');
  late String? _branch = widget.income?.branch ?? '';
  late final TextEditingController _cashController = TextEditingController(
      text: widget.income?.paymentMethods['cash'].toString() ?? '');
  late final TextEditingController _cardsController = TextEditingController(
      text: widget.income?.paymentMethods['cards'].toString() ?? '');
  late final TextEditingController _mercadoPagoController =
      TextEditingController(
          text: widget.income?.paymentMethods['mercadoPago'].toString() ?? '');
  late final TextEditingController _surplusController =
      TextEditingController(text: widget.income?.surplus.toString() ?? '');
  late final TextEditingController _shortageController =
      TextEditingController(text: widget.income?.shortage.toString() ?? '');

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeForm');
    router = AutoRouter.of(context);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _dateField(),
          _branchField(),
          _cashField(),
          _cardsField(),
          _mpField(),
          _surplusField(),
          _shortageField(),
          _submitButton(),
        ],
      ),
    );
  }

  void _submit() {
    _logger.info('Submitting form');

    if (_formKey.currentState!.validate()) {
      try {
        final income = DailyIncome(
          id: widget.income?.id ?? '',
          modifiedAt: DateTime.now(),
          createdAt: widget.income?.createdAt ?? DateTime.now(),
          date: DateTime.parse(_dateController.text),
          branch: _branch!,
          total: widget.income?.total ?? 0.0,
          paymentMethods: {
            'cash': double.parse(_cashController.text),
            'cards': double.parse(_cardsController.text),
            'mercadoPago': double.parse(_mercadoPagoController.text),
          },
          surplus: double.parse(_surplusController.text),
          shortage: double.parse(_shortageController.text),
        );

        if (widget.income == null) {
          _controller.add(income);
          _showSnackbar('Ingreso diario guardado');
        } else {
          _controller.update(income);
          _showSnackbar('Ingreso diario actualizado');
        }

        _logger.info('Form submitted successfully');

        router?.pop();
      } catch (e) {
        _logger.severe('Error occurred while submitting form', e);
        _showSnackbar('Ocurrio un error');
      }
    }
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: _submit,
      child: const Text('Enviar'),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _dateField() {
    return AppFormFields.date(
      labelText: 'Fecha',
      required: true,
      controller: _dateController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _branchField() {
    return BranchField(
      initialValue: _branch,
      onChanged: (value) {
        _branch = value;
        setState(() {});
      },
    );
  }

  Widget _cashField() {
    return AppFormFields.number(
      labelText: 'Efectivo',
      required: true,
      controller: _cashController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _cardsField() {
    return AppFormFields.number(
      labelText: 'Tarjetas',
      required: true,
      controller: _cardsController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _mpField() {
    return AppFormFields.number(
      labelText: 'Mercado Pago',
      required: true,
      controller: _mercadoPagoController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _surplusField() {
    return AppFormFields.number(
      labelText: 'Sobrante',
      controller: _surplusController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  Widget _shortageField() {
    return AppFormFields.number(
      labelText: 'Faltante',
      controller: _shortageController,
      onFieldSubmitted: (value) => _submit(),
    );
  }

  @override
  void dispose() {
    _logger.info('Disposing DailyIncomeForm');

    _dateController.dispose();
    _cashController.dispose();
    _cardsController.dispose();
    _mercadoPagoController.dispose();
    _surplusController.dispose();
    _shortageController.dispose();
    super.dispose();
  }
}
