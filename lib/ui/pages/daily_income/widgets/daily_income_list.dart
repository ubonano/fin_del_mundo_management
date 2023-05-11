import 'package:flutter/material.dart';
import '../../../../models/daily_income.dart';
import 'daily_income_tile.dart';

class DailyIncomeList extends StatefulWidget {
  final List<DailyIncome> incomes;
  final void Function(DailyIncome income)? onDeletePressed;

  const DailyIncomeList({
    super.key,
    required this.incomes,
    this.onDeletePressed,
  });

  @override
  State<DailyIncomeList> createState() => _DailyIncomeListState();
}

class _DailyIncomeListState extends State<DailyIncomeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.incomes.length,
      itemBuilder: (context, index) => DailyIncomeTile(
        income: widget.incomes[index],
        onDeletePressed: widget.onDeletePressed != null
            ? () => widget.onDeletePressed!(widget.incomes[index])
            : null,
      ),
    );
  }
}
