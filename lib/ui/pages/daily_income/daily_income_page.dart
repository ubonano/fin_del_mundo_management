import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_month_filter.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_year_filter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'widgets/daily_income_branch_filter.dart';
import 'widgets/daily_income_add_button.dart';
import 'widgets/daily_income_list.dart';
import 'widgets/daily_income_total_display.dart';

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
          Row(
            children: [
              DailyIncomeBranchFilter(),
              DailyIncomeMonthFilter(),
              DailyIncomeYearFilter(),
              DailyIncomeTotalDisplay(),
            ],
          ),
          DailyIncomeList(),
        ],
      ),
      floatingActionButton: DailyIncomeAddButton(),
    );
  }
}
