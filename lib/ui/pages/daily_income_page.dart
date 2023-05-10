import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../controllers/daily_income_controller.dart';
import '../../models/daily_income.dart';
import '../../setup/get_it_setup.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: StreamBuilder<List<DailyIncome>>(
        stream: _controller.incomes,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              final income = snapshot.data![index];
              return ListTile(
                title: Text(income.branch),
                // Agrega más campos aquí
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _controller.deleteIncome(income);
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
