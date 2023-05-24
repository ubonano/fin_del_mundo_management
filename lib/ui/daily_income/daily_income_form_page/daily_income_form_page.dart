import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/widgets/app_background.dart';
import 'package:flutter/material.dart';
import '../../../../models/daily_income.dart';
import 'widgets/daily_income_form.dart';

@RoutePage()
class DailyIncomeFormPage extends StatelessWidget {
  final DailyIncome? income;

  const DailyIncomeFormPage({Key? key, this.income}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          income == null
              ? 'Registrar ingreso diario'
              : 'Actualizar ingreso diario',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 70),
        child: AppBackgound(child: DailyIncomeForm(income: income)),
      ),
    );
  }
}
