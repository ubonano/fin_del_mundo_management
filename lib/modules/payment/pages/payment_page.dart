import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_navigation_panel.dart';
import '../../../widgets/app_common_filters/app_common_filters.dart';
import '../widgets/payment_category_pie_chart.dart';
import '../widgets/payment_chart.dart';
import '../widgets/payment_panel.dart';

@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos '),
        elevation: 0,
      ),
      body: Row(
        children: [
          const AppNavigationPanel(),
          Expanded(
            child: Column(
              children: [
                AppCommonFilters(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            PaymentChart(),
                            PaymentCategoryPieChart(),
                          ],
                        ),
                      ),
                      PaymentPanel(),
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
