import 'package:flutter/material.dart';

import '../../../../../../../models/daily_income.dart';
import '../../../../../../../utils/app_formaters.dart';

class DailyIncomeInfo extends StatelessWidget {
  final DailyIncome income;

  const DailyIncomeInfo({Key? key, required this.income}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${AppFormaters.getFormattedTotal(income.total)}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        const SizedBox(height: 5),
        Text(
          AppFormaters.getFormattedDate(income.date),
          style: const TextStyle(fontSize: 10.0),
        ),
      ],
    );
  }
}
