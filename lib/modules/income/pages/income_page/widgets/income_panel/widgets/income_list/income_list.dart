import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/widgets/app_stream_builder.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../setup/get_it_setup.dart';
import '../../../../../../../../setup/router.gr.dart';
import '../../../../../../income.dart';
import '../../../../../../income_controller.dart';
import 'widgets/income_tile/income_tile.dart';

class IncomeList extends StatefulWidget {
  const IncomeList({Key? key}) : super(key: key);

  @override
  State<IncomeList> createState() => _IncomeListState();
}

class _IncomeListState extends State<IncomeList> {
  final _controller = getIt<IncomeController>();

  StackRouter get router => AutoRouter.of(context);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<Income>>(
      stream: _controller.incomes,
      onData: (incomes) {
        return Expanded(
          child: ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) => IncomeTile(
              income: incomes[index],
              onEdit: _onEdit,
              onDelete: _onDelete,
            ),
          ),
        );
      },
    );
  }

  _onEdit(income) => router.push(IncomeFormRoute(income: income));

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
