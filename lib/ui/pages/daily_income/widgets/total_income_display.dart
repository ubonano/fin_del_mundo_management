import 'package:flutter/material.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../widgets/app_stream_builder.dart';

class TotalIncomeDisplay extends StatelessWidget {
  final DailyIncomeController controller;

  const TotalIncomeDisplay({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppStreamBuilder<List<DailyIncome>>(
        stream: controller.incomes,
        onData: (incomes) {
          final totalIncome = incomes
              .map((income) => income.total)
              .reduce((value, element) => value + element);
          return Text('Total: \$${totalIncome.toStringAsFixed(2)}');
        },
      ),
    );
  }
}
