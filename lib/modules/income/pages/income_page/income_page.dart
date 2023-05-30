import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'widgets/income_chart.dart';
import 'widgets/income_filters.dart';
import 'widgets/income_panel/income_panel.dart';
import 'widgets/income_collection_methods_chart/income_collection_methods_charts.dart';

@RoutePage()
class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          IncomeFilters(),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      IncomeChart(),
                      IncomeCollectionMethodsPieChart(),
                    ],
                  ),
                ),
                const IncomePanel(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
