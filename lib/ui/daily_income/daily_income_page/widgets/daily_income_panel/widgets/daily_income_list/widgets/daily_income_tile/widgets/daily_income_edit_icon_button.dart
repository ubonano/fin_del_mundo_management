import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../../../../../../../models/daily_income.dart';
import '../../../../../../../../../../setup/router.gr.dart';

class DailyIncomeEditIconButton extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeEditIconButton({Key? key, required this.income})
      : super(key: key);

  @override
  State<DailyIncomeEditIconButton> createState() =>
      _DailyIncomeEditIconButtonState();
}

class _DailyIncomeEditIconButtonState extends State<DailyIncomeEditIconButton> {
  final _logger = Logger('DailyIncomeEditIconButton');
  late StackRouter? router;

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeEditIconButton');
    router = AutoRouter.of(context);

    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        _logger
            .info('Edit button pressed for daily income: ${widget.income.id}');
        router?.push(DailyIncomeFormRoute(income: widget.income));
      },
    );
  }
}
