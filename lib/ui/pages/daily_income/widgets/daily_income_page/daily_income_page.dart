import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_page/daily_income_chart.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_payment_methods_chart/daily_income_payment_methods_charts.dart';
import 'package:flutter/material.dart';
import 'daily_income_filters.dart';
import 'daily_income_panel.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  const DailyIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          DailyIncomeFilters(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DailyIncomeChart(),
                      DailyIncomePaymentMethodsPieChart(),
                    ],
                  ),
                ),
                const DailyIncomePanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
