import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../widgets/app_navigation_panel.dart';
import '../widgets/income_chart.dart';
import '../widgets/income_filters.dart';
import '../widgets/income_panel.dart';
import '../widgets/income_collection_methods_charts.dart';

@RoutePage()
class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos'),
        elevation: 0,
      ),
      body: Row(
        children: [
          const AppNavigationPanel(),
          Expanded(
            child: Column(
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
                      IncomePanel(),
                    ],
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
