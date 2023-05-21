import 'package:flutter/material.dart';

import '../../../../widgets/app_background.dart';

import 'widgets/daily_income_add_button.dart';
import 'widgets/daily_income_list/daily_income_list.dart';
import 'widgets/daily_income_total_display.dart';

class DailyIncomePanel extends StatelessWidget {
  const DailyIncomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppBackgound(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackgroundTitle(title: 'Total de ingresos'),
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
