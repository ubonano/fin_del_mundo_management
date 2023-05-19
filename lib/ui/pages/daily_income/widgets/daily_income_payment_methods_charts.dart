import 'package:fin_del_mundo_management/ui/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:logging/logging.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../../utils/app_formaters.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomePaymentMethodsPieChart extends StatelessWidget {
  final Logger _logger = Logger('PaymentMethodsPieChart');
  final _controller = getIt<DailyIncomeController>();

  DailyIncomePaymentMethodsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    _logger.info('Building PaymentMethodsPieChart');

    return AppBackgound(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Medios de pago',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AppStreamBuilder<List<DailyIncome>>(
              stream: _controller.incomes,
              onData: (incomes) {
                Map<String, double> paymentMethodsTotals = {};

                for (var income in incomes) {
                  income.paymentMethods.forEach(
                    (method, total) {
                      method = _getLabelByMethod(method);
                      paymentMethodsTotals.update(
                        method,
                        (value) => value + total,
                        ifAbsent: () => total,
                      );
                    },
                  );
                }

                List<PieChartSectionData> pieChartSectionDataList =
                    paymentMethodsTotals.entries
                        .map(
                          (e) => PieChartSectionData(
                            value: e.value,
                            title:
                                '${e.key}: \n\$${AppFormaters.getFormattedTotal(e.value)}',
                            color: _getColorByMethod(e.key),
                            radius: 60,
                            showTitle: true,
                            titleStyle: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        )
                        .toList();

                return PieChart(
                  PieChartData(
                    sections: pieChartSectionDataList,
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent touchEvent,
                          PieTouchResponse? touchResponse) {
                        if (touchEvent is FlLongPressEnd) {
                          // Handle touch events here
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorByMethod(String method) {
    switch (method) {
      case 'Efectivo':
        return Colors.green;
      case 'Tarjetas':
        return Colors.orange;
      case 'Mercado Pago':
        return Colors.lightBlue;
      default:
        return Colors.grey;
    }
  }

  String _getLabelByMethod(String method) {
    switch (method) {
      case 'cash':
        return 'Efectivo';
      case 'cards':
        return 'Tarjetas';
      case 'mercadoPago':
        return 'Mercado Pago';
      default:
        return 'paymentMethodNotImplemented*';
    }
  }
}
