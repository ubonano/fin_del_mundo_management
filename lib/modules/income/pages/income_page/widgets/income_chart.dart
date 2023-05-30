import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../setup/get_it_setup.dart';
import '../../../../../widgets/app_background.dart';
import '../../../../../widgets/app_stream_builder.dart';
import '../../../income.dart';
import '../../../income_controller.dart';

class IncomeChart extends StatelessWidget {
  final _controller = getIt<IncomeController>();

  IncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBackgroundTitle(title: 'Ingresos diarios'),
          const SizedBox(height: 12),
          AppStreamBuilder(
            stream: _controller.incomes,
            onData: (incomes) => _buildBarChart(),
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

  List<charts.Series<Income, String>> _getSeries() {
    final dailyIncomes = _controller.fillDailyIncomesForCurrentMonth();

    return [
      charts.Series<Income, String>(
        id: 'Ingresos Diarios',
        domainFn: (dailyIncome, _) => DateFormat('dd').format(dailyIncome.date),
        measureFn: (dailyIncome, _) => dailyIncome.total,
        data: dailyIncomes,
        fillColorFn: (dailyIncome, _) =>
            charts.MaterialPalette.purple.shadeDefault,
      ),
    ];
  }
}
