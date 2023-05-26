import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../modules/income/income_controller.dart';
import '../../../../../modules/income/income.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_formaters.dart';
import '../../../../widgets/app_background.dart';
import '../../../../widgets/app_stream_builder.dart';
import 'widgets/daily_income_payment_method_details.dart';

class DailyIncomePaymentMethodsPieChart extends StatelessWidget {
  final _controller = getIt<IncomeController>();

  DailyIncomePaymentMethodsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackgroundTitle(title: 'Medios de pago'),
          AppStreamBuilder<List<Income>>(
            stream: _controller.incomes,
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
    final paymentMethodsTotals = _controller.calculatePaymentMethodTotals();
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
    final paymentMethodsTotals = _controller.calculatePaymentMethodTotals();
    double total = paymentMethodsTotals.values.fold(0, (a, b) => a + b);

    return paymentMethodsTotals.entries.map(
      (e) {
        double percentage = (e.value / total) * 100;

        return DailyIncomePaymentMethodDetails(
          paymentMethod: e.key,
          percentage: percentage,
          total: AppFormaters.getFormattedTotal(e.value),
        );
      },
    ).toList();
  }
}
