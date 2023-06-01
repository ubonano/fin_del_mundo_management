import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/widgets/app_background.dart';
import 'package:flutter/material.dart';
import '../../income.dart';
import 'widgets/income_form.dart';

@RoutePage()
class IncomeFormPage extends StatelessWidget {
  final Income? income;

  const IncomeFormPage({Key? key, this.income}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 400, vertical: 150),
        child: AppBackgound(child: IncomeForm(income: income)),
      ),
    );
  }
}
