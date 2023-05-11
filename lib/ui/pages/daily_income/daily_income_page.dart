import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/setup/router.gr.dart';
import 'package:flutter/material.dart';
import '../../../controllers/daily_income_controller.dart';
import '../../../models/daily_income.dart';
import '../../../setup/get_it_setup.dart';
import '../../widgets/app_order_delete_dialog.dart';
import '../../widgets/app_stream_builder.dart';
import 'widgets/daily_income_list.dart';

@RoutePage()
class DailyIncomePage extends StatefulWidget {
  const DailyIncomePage({Key? key}) : super(key: key);

  @override
  State<DailyIncomePage> createState() => _DailyIncomePageState();
}

class _DailyIncomePageState extends State<DailyIncomePage> {
  final _controller = getIt<DailyIncomeController>();
  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (data) => DailyIncomeList(
          incomes: data,
          onDeletePressed: (income) {
            AppDialog.showDelete(
              context,
              onPressed: () {
                _controller.delete(income);
                router?.pop();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => router?.push(const DailyIncomeFormRoute()),
      ),
    );
  }
}
