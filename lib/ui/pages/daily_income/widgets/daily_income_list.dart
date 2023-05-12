import 'package:flutter/material.dart';
import 'package:logging/logging.dart'; // Import logging
import '../../../../models/daily_income.dart';
import 'daily_income_tile.dart';

class DailyIncomeList extends StatefulWidget {
  final List<DailyIncome> incomes;
  final void Function(DailyIncome income)? onDeletePressed;

  const DailyIncomeList({
    Key? key,
    required this.incomes,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  State<DailyIncomeList> createState() => _DailyIncomeListState();
}

class _DailyIncomeListState extends State<DailyIncomeList> {
  final _logger = Logger('DailyIncomeList');

  @override
  Widget build(BuildContext context) {
    _logger
        .info('Building DailyIncomeList with ${widget.incomes.length} incomes');
    return ListView.builder(
      itemCount: widget.incomes.length,
      itemBuilder: (context, index) {
        final income = widget.incomes[index];
        _logger.info('Building DailyIncomeTile for income id: ${income.id}');
        return DailyIncomeTile(
          income: income,
          onDeletePressed: widget.onDeletePressed != null
              ? () {
                  _logger.info(
                      'Delete button pressed for income id: ${income.id}');
                  widget.onDeletePressed!(income);
                }
              : null,
        );
      },
    );
  }
}
