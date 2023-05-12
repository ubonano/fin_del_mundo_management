import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/setup/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_stream_builder.dart';
import 'widgets/daily_income_list.dart';

@RoutePage()
class DailyIncomePage extends StatefulWidget {
  const DailyIncomePage({Key? key}) : super(key: key);

  @override
  State<DailyIncomePage> createState() => _DailyIncomePageState();
}

class _DailyIncomePageState extends State<DailyIncomePage> {
  final _logger = Logger('DailyIncomePage');
  final _controller = getIt<DailyIncomeController>();
  late StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    _logger.info('DailyIncomePage: Building DailyIncomePage');

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (incomes) {
          _logger.info('DailyIncomePage: Received daily incomes data');
          return DailyIncomeList(incomes: incomes);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _logger.info('DailyIncomePage: Add button pressed');
          router?.push(DailyIncomeFormRoute());
        },
      ),
    );
  }
}
