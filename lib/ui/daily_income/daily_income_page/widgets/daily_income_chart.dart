import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fin_del_mundo_management/ui/widgets/app_background.dart';
import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';

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
      ),
    );
  }

  List<charts.Series<DailyIncome, String>> _getSeries() {
    return [
      charts.Series(
        id: 'Ingresos Diarios',
        domainFn: (dailyIncome, _) => DateFormat('dd').format(dailyIncome.date),
        measureFn: (dailyIncome, _) => dailyIncome.total,
        data: _controller.fillDailyIncomesForCurrentMonth(),
        fillColorFn: (dailyIncome, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }
}
