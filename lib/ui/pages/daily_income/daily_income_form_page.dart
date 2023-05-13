import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../models/daily_income.dart';
import 'widgets/daily_income_form.dart';

@RoutePage()
class DailyIncomeFormPage extends StatelessWidget {
  final _logger = Logger('DailyIncomePage');
  final DailyIncome? income;

  DailyIncomeFormPage({Key? key, this.income}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('DailyIncomeFormPage: Building DailyIncomeFormPage');
    return Scaffold(
      appBar: AppBar(
        title: Text(income == null
            ? 'Registrar ingreso diario'
            : 'Actualizar ingreso diario'),
      ),
      body: DailyIncomeForm(income: income),
    );
  }
}
