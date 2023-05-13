import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_dialog_confirm.dart';

class DailyIncomeDeleteIconButton extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeDeleteIconButton({
    Key? key,
    required this.income,
  }) : super(key: key);

  @override
  State<DailyIncomeDeleteIconButton> createState() =>
      _DailyIncomeDeleteIconButtonState();
}

class _DailyIncomeDeleteIconButtonState
    extends State<DailyIncomeDeleteIconButton> {
  final _logger = Logger('DailyIncomeTile');
  final _controller = getIt<DailyIncomeController>();
  late StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        _logger.info(
            'Delete button pressed for daily income: ${widget.income.id}');

        AppDialogConfirm.showDeleteDialyIncome(
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
