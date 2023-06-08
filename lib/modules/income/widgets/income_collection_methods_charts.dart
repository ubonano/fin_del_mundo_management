import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../setup/get_it_setup.dart';
import '../../../utils/app_formaters.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_stream_builder.dart';
import '../income_line.dart';
import '../income.dart';
import '../income_controller.dart';

class IncomeCollectionMethodsPieChart extends StatelessWidget {
  final _controller = getIt<IncomeController>();

  IncomeCollectionMethodsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackgroundTitle(title: 'Medios de pago'),
          AppStreamBuilder<List<Income>>(
            stream: _controller.$incomes,
            onData: _buildChart,
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<Income> incomes) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: _buildPieChartSections(),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent touchEvent,
                      PieTouchResponse? touchResponse) {
                    if (touchEvent is FlLongPressEnd) {
                      // Handle touch events here
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildPaymentMethodDetails(),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final paymentMethodsTotals = _controller.calculateCollectionMethodTotals();
    return paymentMethodsTotals.entries
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            color: e.key.getColor(),
            radius: 60,
            showTitle: false,
          ),
        )
        .toList();
  }

  List<Widget> _buildPaymentMethodDetails() {
    final paymentMethodsTotals = _controller.calculateCollectionMethodTotals();
    double total = paymentMethodsTotals.values.fold(0, (a, b) => a + b);

    return paymentMethodsTotals.entries.map(
      (e) {
        double percentage = (e.value / total) * 100;

        return _buildIncomeCollectionMethodDetail(
          collectionItem: e.key,
          percentage: percentage,
          total: AppFormaters.getFormattedTotal(e.value),
        );
      },
    ).toList();
  }

  Widget _buildIncomeCollectionMethodDetail({
    required IncomeLine collectionItem,
    required double percentage,
    required String total,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 16, color: collectionItem.getColor()),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            collectionItem.collectioMethodnName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${percentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$$total',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
