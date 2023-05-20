import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_page/daily_income_chart.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_payment_methods_chart/daily_income_payment_methods_charts.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../widgets/app_background.dart';
import 'daily_income_branch_filter.dart';
import 'daily_income_add_button.dart';
import 'daily_income_list.dart';
import 'daily_income_month_filter.dart';
import 'daily_income_total_display.dart';
import 'daily_income_year_filter.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  DailyIncomePage({Key? key}) : super(key: key);

  final _logger = Logger('DailyIncomePage');

  late final StackRouter? router;

  Widget _buildFilterContainer(Widget child) {
    return AppBackgound(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      margin: const EdgeInsets.only(left: 25, top: 25),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    _logger.info('DailyIncomePage: Building DailyIncomePage');

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                _buildFilterContainer(DailyIncomeBranchFilter()),
                _buildFilterContainer(DailyIncomeMonthFilter()),
                _buildFilterContainer(DailyIncomeYearFilter()),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DailyIncomeChart(),
                      ),
                      Expanded(
                        flex: 1,
                        child: DailyIncomePaymentMethodsPieChart(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: AppBackgound(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total de ingresos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 22.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DailyIncomeTotalDisplay(),
                              const Spacer(),
                              DailyIncomeAddButton(),
                            ],
                          ),
                        ),
                        Expanded(child: DailyIncomeList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
