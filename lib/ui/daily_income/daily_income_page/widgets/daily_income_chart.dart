import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeChart extends StatelessWidget {
  final DailyIncomeController _controller = getIt<DailyIncomeController>();

  DailyIncomeChart({Key? key}) : super(key: key);

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
            onData: (incomes) => _buildBarChart(_getSeries()),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<charts.Series<DailyIncome, String>> series) {
    return Expanded(
      child: charts.BarChart(
        series,
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

  List<charts.Series<DailyIncome, String>> _getSeries() {
    final dailyIncomes = _controller.fillDailyIncomesForCurrentMonth();
    final dailyAverages = _controller.calculateDailyAverage(dailyIncomes);

    return [
      charts.Series<DailyIncome, String>(
        id: 'Ingresos Diarios',
        domainFn: (dailyIncome, _) => DateFormat('dd').format(dailyIncome.date),
        measureFn: (dailyIncome, _) => dailyIncome.total,
        data: dailyIncomes,
        fillColorFn: (dailyIncome, _) =>
            charts.MaterialPalette.purple.shadeDefault,
      ),
      charts.Series<DailyIncome, String>(
        id: 'Promedio Diario',
        domainFn: (dailyIncome, i) => DateFormat('dd').format(dailyIncome.date),
        measureFn: (_, i) => dailyAverages[i!],
        data: dailyIncomes,
        colorFn: (_, __) => charts.MaterialPalette.lime.shadeDefault,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }
}
