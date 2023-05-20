import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../../setup/router.gr.dart';

class DailyIncomeAddButton extends StatelessWidget {
  DailyIncomeAddButton({Key? key}) : super(key: key);

  final _logger = Logger('DailyIncomeAddButton');

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeAddButton');
    return ElevatedButton.icon(
      onPressed: () => _navigateToIncomeForm(context),
      icon: const Icon(Icons.add, color: Colors.white, size: 18),
      label: const Text(
        'Nuevo ingreso',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff5E27FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  void _navigateToIncomeForm(BuildContext context) {
    _logger.info('Navigating to DailyIncomeFormRoute');
    final router = AutoRouter.of(context);
    router.push(DailyIncomeFormRoute());
  }
}
