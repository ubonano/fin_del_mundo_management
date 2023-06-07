import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../widgets/app_background.dart';
import '../../../../../widgets/app_stream_builder.dart';
import '../payment.dart';
import '../payment_controller.dart';

class PaymentChart extends StatelessWidget {
  final _controller = getIt<PaymentController>();

  PaymentChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackgroundTitle(title: 'Gastos diarios'),
          const SizedBox(height: 12),
          AppStreamBuilder(
            stream: _controller.$payments,
            onData: (payments) => _buildBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Expanded(
      child: charts.BarChart(
        _getSeries(),
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelStyle: charts.TextStyleSpec(fontSize: 10),
          ),
        ),
        behaviors: [
          charts.SlidingViewport(),
          charts.PanAndZoomBehavior(),
        ],
        defaultRenderer: charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped,
        ),
        customSeriesRenderers: [
          charts.LineRendererConfig(
            customRendererId: 'customLine',
          ),
        ],
      ),
    );
  }

  List<charts.Series<Payment, String>> _getSeries() {
    final payments = _controller.fillPaymentsForCurrentMonth();

    return [
      charts.Series<Payment, String>(
        id: 'Gastos Diarios',
        domainFn: (payment, _) => DateFormat('dd').format(payment.date),
        measureFn: (payment, _) => payment.total,
        data: payments,
        fillColorFn: (dailyIncome, _) =>
            charts.MaterialPalette.purple.shadeDefault,
      ),
    ];
  }
}
