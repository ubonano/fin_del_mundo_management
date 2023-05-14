import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../utils/app_formaters.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeTotalDisplay extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();
  final _logger = Logger('DailyIncomeTotalDisplay');

  DailyIncomeTotalDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeTotalDisplay');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (incomes) => Text('Total: \$${_calculateTotalIncome(incomes)}'),
      ),
    );
  }

  String _calculateTotalIncome(List<DailyIncome> incomes) {
    _logger.info('Calculating Total Income');

    if (incomes.isEmpty) {
      return '0';
    } else {
      final totalIncome = incomes
          .map((income) => income.total)
          .reduce((value, element) => value + element);
      return AppFormaters.getFormattedTotal(totalIncome);
    }
  }
}
