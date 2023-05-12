import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/setup/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_order_delete_dialog.dart';
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
  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);
    _logger.info('Building DailyIncomePage');

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (data) {
          _logger.info('Received daily incomes data');
          return DailyIncomeList(
            incomes: data,
            onDeletePressed: (income) {
              _logger
                  .info('Delete button pressed for daily income: ${income.id}');
              AppDialog.showDelete(
                context,
                onPressed: () => onDeletePressed(income),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _logger.info('Add button pressed');
          router?.push(const DailyIncomeFormRoute());
        },
      ),
    );
  }

  void onDeletePressed(DailyIncome income) {
    _logger.info('Deleting daily income: ${income.id}');
    try {
      _controller.delete(income);
      router?.pop();
      _logger.info('Daily income deleted successfully');
    } catch (e) {
      _logger.severe('Error deleting daily income: ${e.toString()}');
      _showSnackbar('An error occurred');
    }
  }

  void _showSnackbar(String message) {
    _logger.info('Showing snackbar with message: $message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
