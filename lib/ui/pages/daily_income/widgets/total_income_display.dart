import 'package:flutter/material.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_stream_builder.dart';

class TotalIncomeDisplay extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  TotalIncomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (incomes) {
          String ret = '';
          if (incomes.isEmpty) {
            ret = '0';
          } else {
            final totalIncome = incomes
                .map((income) => income.total)
                .reduce((value, element) => value + element);
            ret = totalIncome.toStringAsFixed(2);
          }
          return Text('Total: $ret');
        },
      ),
    );
  }
}
