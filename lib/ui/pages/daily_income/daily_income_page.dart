import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'widgets/branch_filter.dart';
import 'widgets/daily_income_add_button.dart';
import 'widgets/daily_income_list.dart';
import 'widgets/total_income_display.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  DailyIncomePage({Key? key}) : super(key: key);

  final _logger = Logger('DailyIncomePage');

  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    _logger.info('DailyIncomePage: Building DailyIncomePage');

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          Row(children: [BranchFilter(), TotalIncomeDisplay()]),
          DailyIncomeList(),
        ],
      ),
      floatingActionButton: const DailyIncomeAddButton(),
    );
  }
}
