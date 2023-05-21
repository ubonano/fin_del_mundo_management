import 'package:flutter/material.dart';

import '../../../../widgets/app_background.dart';

import 'daily_income_add_button.dart';
import 'daily_income_list.dart';
import 'daily_income_total_display.dart';

class DailyIncomePanel extends StatelessWidget {
  const DailyIncomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppBackgound(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total de ingresos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 22.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DailyIncomeTotalDisplay(),
                  const DailyIncomeAddButton(),
                ],
              ),
            ),
            DailyIncomeList(),
          ],
        ),
      ),
    );
  }
}
