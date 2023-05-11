import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/widgets/app_order_delete_dialog.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import 'daily_income_tile.dart';

class DailyIncomeList extends StatefulWidget {
  final List<DailyIncome> incomes;
  late final StackRouter? router;
  DailyIncomeList({super.key, required this.incomes});

  @override
  State<DailyIncomeList> createState() => _DailyIncomeListState();
}

class _DailyIncomeListState extends State<DailyIncomeList> {
  final _controller = getIt<DailyIncomeController>();

  @override
  Widget build(BuildContext context) {
    widget.router = AutoRouter.of(context);

    return ListView.builder(
      itemCount: widget.incomes.length,
      itemBuilder: (context, index) => DailyIncomeTile(
        income: widget.incomes[index],
        onDeletePressed: () => onDeletePressed(widget.incomes[index]),
      ),
    );
  }

  void onDeletePressed(DailyIncome income) {
    AppDialog.showDelete(
      context,
      onPressed: () {
        _controller.delete(income);
        widget.router?.pop();
      },
    );
  }
}
