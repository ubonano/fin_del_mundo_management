import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import '../../../../../../../controllers/daily_income_controller.dart';
import '../../../../../../../models/daily_income.dart';
import '../../../../../../../setup/get_it_setup.dart';
import '../../../../../../../setup/router.gr.dart';
import 'widgets/daily_income_tile/daily_income_tile.dart';

class DailyIncomeList extends StatefulWidget {
  const DailyIncomeList({Key? key}) : super(key: key);

  @override
  State<DailyIncomeList> createState() => _DailyIncomeListState();
}

class _DailyIncomeListState extends State<DailyIncomeList> {
  final _controller = getIt<DailyIncomeController>();

  StackRouter get router => AutoRouter.of(context);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<DailyIncome>>(
      stream: _controller.incomes,
      onData: (incomes) {
        return Expanded(
          child: ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) => DailyIncomeTile(
              income: incomes[index],
              onEdit: _onEdit,
              onDelete: _onDelete,
            ),
          ),
        );
      },
    );
  }

  _onEdit(income) => router.push(DailyIncomeFormRoute(income: income));

  _onDelete(income) {
    try {
      _controller.delete(income);
      router.pop();
    } catch (e) {
      _showSnackbar('Ocurrio un error...');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
