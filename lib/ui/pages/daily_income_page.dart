import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/daily_income_controller.dart';
import '../../models/daily_income.dart';
import '../../setup/get_it_setup.dart';
import '../widgets/app_stream_builder.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: AppStreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        onData: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final income = data[index];
              return ListTile(
                title: Text(income.branch),
                subtitle: Text(
                  'Date: ${DateFormat('EEEE dd-MM-yyyy').format(income.date)}\n'
                  'Total: ${income.total.toStringAsFixed(2)}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _controller.delete(income);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Aquí puede ir la lógica para agregar un nuevo ingreso
        },
      ),
    );
  }
}
