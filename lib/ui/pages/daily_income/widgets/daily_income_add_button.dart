import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../setup/router.gr.dart';

class DailyIncomeAddButton extends StatelessWidget {
  DailyIncomeAddButton({Key? key}) : super(key: key);

  final _logger = Logger('DailyIncomeAddButton');

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeAddButton');
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _navigateToIncomeForm(context),
    );
  }

  void _navigateToIncomeForm(BuildContext context) {
    _logger.info('Navigating to DailyIncomeFormRoute');
    final router = AutoRouter.of(context);
    router.push(DailyIncomeFormRoute());
  }
}
