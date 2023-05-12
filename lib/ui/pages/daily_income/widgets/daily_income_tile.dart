import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../setup/router.gr.dart';
import '../../../widgets/app_order_delete_dialog.dart';

class DailyIncomeTile extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeTile({
    Key? key,
    required this.income,
  }) : super(key: key);

  @override
  State<DailyIncomeTile> createState() => _DailyIncomeTileState();
}

class _DailyIncomeTileState extends State<DailyIncomeTile> {
  final _controller = getIt<DailyIncomeController>();
  final _logger = Logger('DailyIncomeTile');
  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    _logger.info('Building DailyIncomeTile for income id: ${widget.income.id}');

    return ListTile(
      title: Text(widget.income.branch),
      subtitle: Text(
        'Date: ${DateFormat('EEEE dd-MM-yyyy').format(widget.income.date)}\n'
        'Total: ${widget.income.total.toStringAsFixed(2)}',
      ),
      onTap: () {
        _logger.info('Tile pressed for daily income: ${widget.income.id}');
        router?.push(DailyIncomeFormRoute(income: widget.income));
      },
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: _onDeletePressed,
      ),
    );
  }

  void _onDeletePressed() {
    _logger.info('Delete button pressed for daily income: ${widget.income.id}');
    AppDialog.showDelete(
      context,
      onPressed: () {
        _logger.info('Deleting daily income: ${widget.income.id}');
        try {
          _controller.delete(widget.income);
          router?.pop();
          _logger.info('Daily income deleted successfully');
        } catch (e) {
          _logger.severe('Error deleting daily income: ${e.toString()}');
          _showSnackbar('An error occurred');
        }
      },
    );
  }

  void _showSnackbar(String message) {
    _logger.info('Showing snackbar with message: $message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
