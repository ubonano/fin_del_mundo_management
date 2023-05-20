import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fin_del_mundo_management/ui/widgets/app_background.dart';
import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../models/daily_income.dart';
import '../../../../../setup/get_it_setup.dart';

class DailyIncomeChart extends StatelessWidget {
  final Logger _logger = Logger('DailyIncomeChart');
  final DailyIncomeController _controller = getIt<DailyIncomeController>();

  DailyIncomeChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeChart');
    return AppBackgound(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ingresos diarios',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AppStreamBuilder(
              stream: _controller.incomes,
              onData: (incomes) => _buildBarChart(_getSeries()),
            ),
          ),
        ],
      ),
    );
  }

  List<charts.Series<DailyIncome, String>> _getSeries() {
    _logger.info('Gettin series');
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

  Widget _buildBarChart(List<charts.Series<DailyIncome, String>> series) {
    _logger.info('Building Chart');
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
  }
}
