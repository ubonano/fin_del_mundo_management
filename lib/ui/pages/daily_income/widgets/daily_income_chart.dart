import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';

class DailyIncomeChart extends StatelessWidget {
  final _logger = Logger('DailyIncomeList');
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeChart({super.key});

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeChart');

    return Expanded(
      child: AppStreamBuilder(
        stream: _controller.incomes,
        onData: (incomes) {
          List<DailyIncome> dailyIncomesForMonth =
              _controller.fillDailyIncomesForMonth(incomes);

          List<charts.Series<DailyIncome, String>> series = [
            charts.Series(
                id: 'Ingresos Diarios',
                domainFn: (dailyIncome, _) =>
                    DateFormat('MM-dd').format(dailyIncome.date),
                measureFn: (dailyIncome, _) => dailyIncome.total,
                data: dailyIncomesForMonth,
                fillColorFn: (dailyIncome, _) =>
                    charts.MaterialPalette.blue.shadeDefault),
          ];

          return charts.BarChart(
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
          );
        },
      ),
    );
  }
}
