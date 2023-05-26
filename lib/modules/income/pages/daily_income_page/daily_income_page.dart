import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'widgets/daily_income_chart.dart';
import 'widgets/daily_income_filters.dart';
import 'widgets/daily_income_panel/daily_income_panel.dart';
import 'widgets/daily_income_payment_methods_chart/daily_income_payment_methods_charts.dart';

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
