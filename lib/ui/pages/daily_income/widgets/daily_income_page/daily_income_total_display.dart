import 'package:flutter/material.dart';
import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../models/daily_income.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_formaters.dart';
import '../../../../widgets/app_stream_builder.dart';

class DailyIncomeTotalDisplay extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeTotalDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<List<DailyIncome>>(
      stream: _controller.incomes,
      onData: (incomes) => Text(
        '\$${_calculateTotalIncome(incomes)}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xff8278A1),
        ),
      ),
    );
  }

  String _calculateTotalIncome(List<DailyIncome> incomes) {
    if (incomes.isEmpty) {
      return '0';
    } else {
      final totalIncome = incomes
          .map((income) => income.total)
          .reduce((value, element) => value + element);
      return AppFormaters.getFormattedTotal(totalIncome);
    }
  }
}
