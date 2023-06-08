import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/modules/collection_method/widgets/collection_method_dropdown_field.dart';
import 'package:fin_del_mundo_management/modules/income_category/income_category.dart';
import 'package:fin_del_mundo_management/modules/income_category/widgets/income_category_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../setup/get_it_setup.dart';
import '../../../widgets/app_form_field.dart';
import '../../branch/branch.dart';
import '../../branch/widgets/branch_dropdown_field.dart';
import '../../collection_method/collection_method.dart';
import '../../income_category/income_category_controller.dart';
import '../income_line.dart';
import '../income.dart';
import '../income_controller.dart';

class IncomeForm extends StatefulWidget {
  final Income? income;

  const IncomeForm({Key? key, this.income}) : super(key: key);

  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StackRouter get router => AutoRouter.of(context);

  final _incomeController = getIt<IncomeController>();
  final _categoryController = getIt<IncomeCategoryController>();

  int _lineIdCounter = 0;

  late final TextEditingController _dateController;
  late Branch? _branch;
  late final TextEditingController _totalController;
  final List<IncomeLine> _lines = [];

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

    if (widget.income != null) {
      widget.income!.lines.forEach((line) {
        _lines.add(IncomeLine(
            id: _lineIdCounter++,
            method: line.method,
            category: line.category,
            amount: line.amount,
            controller: TextEditingController(text: line.amount.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRow(),
          _buildIncomeLines(),
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
        const SizedBox(width: 20),
        _buildAddLineButton(),
      ],
    );
  }

  Widget _buildIncomeLines() {
    return Column(
      children: _lines.map((line) => _buildIncomeLine(line)).toList(),
    );
  }

  Widget _buildIncomeLine(IncomeLine line) {
    return Row(
      children: [
        _buildIncomeCategoryField(line),
        const SizedBox(width: 8),
        _buildCollectionMethodField(line),
        const SizedBox(width: 8),
        _buildAmountField(line),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _lines.remove(line);
              _updateTotal();
            });
          },
        ),
      ],
    );
  }

  Widget _buildAddLineButton() {
    return ElevatedButton(
      child: const Text('Agregar línea'),
      onPressed: () {
        setState(() {
          _lines.add(
            IncomeLine(
              id: _lineIdCounter++,
              method: CollectionMethod(id: '', name: ''),
              category: IncomeCategory(
                id: '',
                name: '',
                branch: Branch(id: '', name: ''),
              ),
            ),
          );
        });
      },
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
          setState(() {
            _branch = value;
            _categoryController.loadByBranch(_branch!);
            _lines.clear();
            _updateTotal();
          });
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

  Widget _buildIncomeCategoryField(IncomeLine line) {
    return Expanded(
      child: IncomeCategoryDropdownField(
        initialValue: line.category.id != '' ? line.category : null,
        branchFilter: _branch,
        onChanged: (category) {
          setState(() {
            line.category = category!;
          });
        },
      ),
    );
  }

  Widget _buildCollectionMethodField(IncomeLine line) {
    return Expanded(
      child: CollectionMethodDropdownField(
        initialValue: line.method.id != '' ? line.method : null,
        onChanged: (CollectionMethod? newValue) {
          setState(() {
            line.method = newValue!;
          });
        },
      ),
    );
  }

  Widget _buildAmountField(IncomeLine line) {
    line.controller = line.controller ?? TextEditingController();
    line.controller!.addListener(() {
      setState(() {
        line.amount = double.tryParse(line.controller!.text) ?? 0;
        _updateTotal();
      });
    });

    return Expanded(
      child: AppFormField.number(
        labelText: 'Monto',
        required: true,
        controller: line.controller!,
      ),
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final income = _getIncomeToSave();

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

  Income _getIncomeToSave() {
    return Income(
      id: widget.income?.id ?? '',
      date: DateTime.parse(_dateController.text),
      branch: _branch!,
      lines: _lines,
    );
  }

  void _updateTotal() {
    double total = 0;
    _lines.forEach((line) {
      total += line.amount;
    });
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
    _lines.forEach((line) => line.controller?.dispose());
    _totalController.dispose();
    super.dispose();
  }
}
