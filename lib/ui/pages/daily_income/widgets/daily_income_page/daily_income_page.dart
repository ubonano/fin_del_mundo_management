import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_page/daily_income_chart.dart';
import 'package:fin_del_mundo_management/ui/pages/daily_income/widgets/daily_income_payment_methods_chart/daily_income_payment_methods_charts.dart';
import 'package:flutter/material.dart';
import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_date_time.dart';
import '../../../../widgets/app_background.dart';
import 'daily_income_add_button.dart';
import 'daily_income_list.dart';
import '../../../../widgets/app_dropdown_button.dart';
import 'daily_income_total_display.dart';

@RoutePage()
class DailyIncomePage extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingresos diarios')),
      body: Column(
        children: [
          Row(
            children: [
              AppDropdownButton(
                items: AppDateTime.generateYears(),
                streamData: _controller.selectedYear,
                onChanged: (newValue) => _controller.filterByYear(newValue!),
              ),
              AppDropdownButton(
                items: AppDateTime.generateAllMonths(),
                streamData: _controller.selectedMonth,
                onChanged: (newValue) => _controller.filterByMonth(newValue!),
              ),
              AppDropdownButton(
                items: const <String>['All', 'Restaurante', 'Discoteca'],
                streamData: _controller.selectedBranch,
                onChanged: (newValue) => _controller.filterByBranch(newValue!),
              ),
            ],
          ),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DailyIncomeChart(),
                      ),
                      Expanded(
                        flex: 1,
                        child: DailyIncomePaymentMethodsPieChart(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 22.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DailyIncomeTotalDisplay(),
                              const Spacer(),
                              const DailyIncomeAddButton(),
                            ],
                          ),
                        ),
                        Expanded(child: DailyIncomeList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
