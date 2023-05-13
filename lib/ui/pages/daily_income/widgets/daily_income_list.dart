import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../models/daily_income.dart';
import 'daily_income_tile.dart';

class DailyIncomeList extends StatelessWidget {
  final List<DailyIncome> incomes;
  final _logger = Logger('DailyIncomeList');

  DailyIncomeList({Key? key, required this.incomes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeList with ${incomes.length} incomes');
    return ListView.builder(
      itemCount: incomes.length,
      itemBuilder: (context, index) {
        final income = incomes[index];
        _logger.info('Building DailyIncomeTile for income id: ${income.id}');
        return DailyIncomeTile(income: income);
      },
    );
  }
}
