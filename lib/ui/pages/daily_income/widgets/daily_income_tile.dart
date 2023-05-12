import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../models/daily_income.dart';

class DailyIncomeTile extends StatelessWidget {
  final DailyIncome income;
  final void Function()? onDeletePressed;
  final _logger = Logger('DailyIncomeTile');

  DailyIncomeTile({
    Key? key,
    required this.income,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeTile for income id: ${income.id}');
    return ListTile(
      title: Text(income.branch),
      subtitle: Text(
        'Date: ${DateFormat('EEEE dd-MM-yyyy').format(income.date)}\n'
        'Total: ${income.total.toStringAsFixed(2)}',
      ),
      trailing: onDeletePressed != null
          ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _logger
                    .info('Delete button pressed for income id: ${income.id}');
                onDeletePressed!();
              },
            )
          : null,
    );
  }
}
