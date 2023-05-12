import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
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
  final _logger = Logger('DailyIncomePage');

  @override
  void initState() {
    super.initState();
    _logger.info('DailyIncomeFormPage: Initializing DailyIncomeFormPage');
  }

  @override
  Widget build(BuildContext context) {
    _logger.info('DailyIncomeFormPage: Building DailyIncomeFormPage');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.income == null
            ? 'Registrar ingreso diario'
            : 'Actualizar ingreso diario'),
      ),
      body: DailyIncomeForm(income: widget.income),
    );
  }

  @override
  void dispose() {
    _logger.info('DailyIncomeFormPage: Disposing DailyIncomeFormPage');
    super.dispose();
  }
}
