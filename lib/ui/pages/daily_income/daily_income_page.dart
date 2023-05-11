import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_order_delete_dialog.dart';
import '../../widgets/app_stream_builder.dart';
import 'widgets/daily_income_list.dart';

@RoutePage()
class DailyIncomePage extends StatefulWidget {
  late final StackRouter? router;

  DailyIncomePage({Key? key}) : super(key: key);

  @override
  State<DailyIncomePage> createState() => _DailyIncomePageState();
}

class _DailyIncomePageState extends State<DailyIncomePage> {
  final _controller = getIt<DailyIncomeController>();

  @override
  Widget build(BuildContext context) {
    widget.router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (data) => DailyIncomeList(
          incomes: data,
          onDeletePressed: onDeletePressed,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Aquí puede ir la lógica para agregar un nuevo ingreso
        },
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
