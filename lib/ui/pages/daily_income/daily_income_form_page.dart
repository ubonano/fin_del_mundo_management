import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../models/daily_income.dart';

import 'widgets/daily_income_form.dart';

@RoutePage()
class DailyIncomeFormPage extends StatefulWidget {
  final DailyIncome? income;

  const DailyIncomeFormPage({Key? key, this.income}) : super(key: key);

  @override
  _DailyIncomeFormPageState createState() => _DailyIncomeFormPageState();
}

class _DailyIncomeFormPageState extends State<DailyIncomeFormPage> {
  late final StackRouter? router;

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.income == null
              ? 'Registrar ingreso diario'
              : 'Actualizar ingreso diario')),
      body: DailyIncomeForm(income: widget.income),
    );
  }
}
