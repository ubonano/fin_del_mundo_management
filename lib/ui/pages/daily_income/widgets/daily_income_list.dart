import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';

class DailyIncomeList extends StatelessWidget {
  final List<DailyIncome> incomes;

  const DailyIncomeList({super.key, required this.incomes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: incomes.length,
      itemBuilder: (context, index) => _DailyIncomeTile(income: incomes[index]),
    );
  }
}

class _DailyIncomeTile extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();
  final DailyIncome income;

  _DailyIncomeTile({super.key, required this.income});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(income.branch),
      subtitle: Text(
        'Date: ${DateFormat('EEEE dd-MM-yyyy').format(income.date)}\n'
        'Total: ${income.total.toStringAsFixed(2)}',
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () =>
            _controller.delete(income), // TODO CREAR Dialogo de confirmacion
      ),
    );
  }
}
