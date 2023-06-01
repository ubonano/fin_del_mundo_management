import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../widgets/app_form_field.dart';
import '../../../../../widgets/app_stream_builder.dart';
import '../../../../branch/branch.dart';
import '../../../../branch/widgets/branch_dropdown_field.dart';
import '../../../../collection_method/collection_method.dart';
import '../../../../collection_method/collection_methods_controller.dart';
import '../../../../collection_method/utils/collection_method_item.dart';
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

  final Map<String, TextEditingController> _collectionMethodControllerAndItem =
      {};

  StackRouter get router => AutoRouter.of(context);

  final _incomeController = getIt<IncomeController>();
  final _collectionMethodController = getIt<CollectionMethodController>();

  late final TextEditingController _dateController = TextEditingController(
      text: widget.income?.date != null
          ? DateFormat('yyyy-MM-dd').format(widget.income!.date)
          : '');
  late Branch? _branch = widget.income?.branch;

  late List<TextEditingController> _collectionMethodControllers;

  late final TextEditingController _totalController =
      TextEditingController(text: widget.income?.total.toString() ?? '0');

  @override
  void initState() {
    super.initState();

    _collectionMethodControllers = widget.income?.collectionMethodItems
            .map(
              (method) => TextEditingController(
                text: method.name,
              ),
            )
            .toList() ??
        [];
  }

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
          AppStreamBuilder<List<CollectionMethod>>(
            stream: _collectionMethodController.collectionMethods,
            onData: (data) => Column(children: _collectionMethodFields(data)),
          ),
          _totalField(),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Enviar'),
          ),
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
        initialValue: widget.income?.branch,
        onChanged: (value) {
          _branch = value;
          setState(() {});
        },
      ),
    );
  }

  List<Widget> _collectionMethodFields(List<CollectionMethod> data) {
    return data.map((item) {
      String text;
      try {
        text = widget.income?.collectionMethodItems
                .firstWhere((witem) => witem.name == item.name)
                .amount
                .toString() ??
            '';
      } catch (e) {
        text = '';
      }
      final controller = TextEditingController(text: text);
      _collectionMethodControllerAndItem[item.name] = controller;
      _collectionMethodControllers.add(controller);

      return AppFormField.number(
        labelText: item.name,
        required: true,
        controller: controller,
        onFieldSubmitted: (value) => _submit(),
        onChanged: (value) => _updateTotal(),
      );
    }).toList();
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

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final income = _getDailyIncomeToSave();

        if (widget.income == null) {
          await _incomeController.add(income);
          _showSnackbar('Ingreso diario guardado');
        } else {
          await _incomeController.update(income);
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
      date: DateTime.parse(_dateController.text),
      branch: _branch!,
      collectionMethodItems: _collectionMethodControllerAndItem.entries.map(
        (controllerItem) {
          return CollectionMethodItem(
            name: controllerItem.key,
            amount: double.parse(controllerItem.value.text),
          );
        },
      ).toList(),
    );
  }

  void _updateTotal() {
    double total = 0;
    _collectionMethodControllers.forEach(
      (controller) {
        total += double.tryParse(controller.text) ?? 0;
      },
    );
    _totalController.text = total.toString();
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _collectionMethodControllers.forEach((controller) => controller.dispose());
    _totalController.dispose();

    super.dispose();
  }
}
