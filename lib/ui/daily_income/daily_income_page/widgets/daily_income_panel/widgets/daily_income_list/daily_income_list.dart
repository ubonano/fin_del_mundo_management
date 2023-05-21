import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import '../../../../../../../controllers/daily_income_controller.dart';
import '../../../../../../../models/daily_income.dart';
import '../../../../../../../setup/get_it_setup.dart';
import 'widgets/daily_income_tile/daily_income_tile.dart';

class DailyIncomeList extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (incomes) {
          return ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) =>
                DailyIncomeTile(income: incomes[index]),
          );
        },
      ),
    );
  }
}
