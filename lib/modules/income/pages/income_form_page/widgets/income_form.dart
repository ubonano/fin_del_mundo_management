import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../widgets/app_form_field.dart';
import '../../../../../widgets/app_stream_builder.dart';
import '../../../../branch/branch.dart';
import '../../../../branch/widgets/branch_dropdown_field.dart';
import '../../../../collection_method/collection_method.dart';
import '../../../../collection_method/collection_method_controller.dart';
import '../../../../collection_method/helpers/collection_item.dart';
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

  late final TextEditingController _dateController;
  late Branch? _branch;
  final List<TextEditingController> _collectionMethodControllers = [];
  late final TextEditingController _totalController;

  @override
  void initState() {
    super.initState();

    _dateController = TextEditingController(
        text: widget.income?.date != null
            ? DateFormat('yyyy-MM-dd').format(widget.income!.date)
            : '');

    _branch = widget.income?.branch;

    _totalController =
        TextEditingController(text: widget.income?.total.toString() ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRow(),
          _buildCollectionMethodFieldsStream(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      children: [
        _dateField(),
        const SizedBox(width: 20),
        _branchField(),
        const SizedBox(width: 20),
        _buildTotalField(),
      ],
    );
  }

  Widget _buildCollectionMethodFieldsStream() {
    return AppStreamBuilder<List<CollectionMethod>>(
      stream: _collectionMethodController.collectionMethods,
      onData: (data) => Column(children: _collectionMethodFields(data)),
    );
  }

  ElevatedButton _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      child: const Text('Enviar'),
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

  Widget _buildTotalField() {
    return Expanded(
      child: AppFormField.number(
        labelText: 'Total',
        enabled: false,
        controller: _totalController,
      ),
    );
  }

  List<Widget> _collectionMethodFields(
      List<CollectionMethod> collectionMethods) {
    return collectionMethods
        .map((item) => _buildCollectionMethodField(item))
        .toList();
  }

  Widget _buildCollectionMethodField(CollectionMethod collectionMethod) {
    String amount = _getCollectionMethodItemAmount(collectionMethod);

    final controller = TextEditingController(text: amount);

    _collectionMethodControllerAndItem[collectionMethod.name] = controller;
    _collectionMethodControllers.add(controller);

    return AppFormField.number(
      labelText: collectionMethod.name,
      required: false,
      controller: controller,
      onFieldSubmitted: (value) => _submit(),
      onChanged: (value) => _updateTotal(),
    );
  }

  String _getCollectionMethodItemAmount(CollectionMethod collectionMethod) {
    String amount;
    try {
      amount = widget.income?.collectionItems
              .firstWhere((witem) => witem.name == collectionMethod.name)
              .amount
              .toString() ??
          '';
    } catch (e) {
      amount = '';
    }
    return amount;
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final income = _getDailyIncomeToSave();

        if (widget.income == null) {
          await _incomeController.add(income);
        } else {
          await _incomeController.update(income);
        }
        _showSnackbar('Ingreso diario guardado');

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
      collectionItems: _collectionMethodControllerAndItem.entries.map(
        (controllerItem) {
          return CollectionItem(
            name: controllerItem.key,
            amount: controllerItem.value.text != ''
                ? double.parse(controllerItem.value.text)
                : 0,
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
