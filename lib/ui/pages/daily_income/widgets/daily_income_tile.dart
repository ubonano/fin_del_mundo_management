import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../models/daily_income.dart';

class DailyIncomeTile extends StatelessWidget {
  final DailyIncome income;
  final void Function()? onDeletePressed;

  const DailyIncomeTile(
      {super.key, required this.income, required this.onDeletePressed});

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
        onPressed: onDeletePressed,
      ),
    );
  }
}
