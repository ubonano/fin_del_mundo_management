import 'package:flutter/material.dart';

import '../../../../../../widgets/app_background.dart';
import 'widgets/income_add_button.dart';
import 'widgets/income_list/income_list.dart';
import 'widgets/income_total_display.dart';

class IncomePanel extends StatelessWidget {
  const IncomePanel({super.key});

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
              child: _buildTop(),
            ),
            const IncomeList(),
          ],
        ),
      ),
    );
  }

  Row _buildTop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IncomeTotalDisplay(),
        const IncomeAddButton(),
      ],
    );
  }
}
