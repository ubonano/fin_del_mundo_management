import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/daily_income_form.dart';

@RoutePage()
class DailyIncomeFormPage extends StatefulWidget {
  const DailyIncomeFormPage({Key? key}) : super(key: key);

  @override
  _DailyIncomeFormPageState createState() => _DailyIncomeFormPageState();
}

class _DailyIncomeFormPageState extends State<DailyIncomeFormPage> {
  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar ingreso diario')),
      body: const DailyIncomeForm(),
    );
  }
}
