import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_stream_builder.dart';
import 'widgets/branch_filter.dart';
import 'widgets/daily_income_add_button.dart';
import 'widgets/daily_income_list.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  DailyIncomePage({Key? key}) : super(key: key);

  final _logger = Logger('DailyIncomePage');

  final _controller = getIt<DailyIncomeController>();

  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    _logger.info('DailyIncomePage: Building DailyIncomePage');

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          BranchFilter(),
          Expanded(
            child: AppStreamBuilder<List<DailyIncome>>(
              stream: _controller.incomes,
              onData: (incomes) {
                _logger.info(
                    'DailyIncomePage: Received daily incomes data [${incomes.length}]');
                return DailyIncomeList(incomes: incomes);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const DailyIncomeAddButton(),
    );
  }
}
