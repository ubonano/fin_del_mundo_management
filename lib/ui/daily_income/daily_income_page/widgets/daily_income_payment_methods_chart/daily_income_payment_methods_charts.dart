import 'package:fin_del_mundo_management/ui/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../controllers/daily_income_controller.dart';
import '../../../../../models/daily_income.dart';
import '../../../../../setup/get_it_setup.dart';
import '../../../../../utils/app_formaters.dart';
import '../../../../widgets/app_stream_builder.dart';
import 'widgets/daily_income_payment_method_details.dart';

class DailyIncomePaymentMethodsPieChart extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomePaymentMethodsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackgound(
      height: 250,
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

                return Row(
                  children: [
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sections:
                              _buildPieChartSections(paymentMethodsTotals),
                          pieTouchData: PieTouchData(
                            touchCallback: (FlTouchEvent touchEvent,
                                PieTouchResponse? touchResponse) {
                              if (touchEvent is FlLongPressEnd) {
                                // Handle touch events here
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            _buildPaymentMethodDetails(paymentMethodsTotals),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorByMethod(String method) {
    Map<String, Color> methodsColors = {
      'Efectivo': Colors.green,
      'Tarjetas': Colors.orange,
      'Mercado Pago': Colors.lightBlue,
      'paymentMethodNotImplemented*': Colors.grey,
    };

    return methodsColors[method] ?? Colors.grey;
  }

  String _getLabelByMethod(String method) {
    Map<String, String> methodsLabels = {
      'cash': 'Efectivo',
      'cards': 'Tarjetas',
      'mercadoPago': 'Mercado Pago',
    };

    return methodsLabels[method] ?? 'paymentMethodNotImplemented*';
  }

  List<PieChartSectionData> _buildPieChartSections(
      Map<String, double> paymentMethodsTotals) {
    return paymentMethodsTotals.entries
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            color: _getColorByMethod(e.key),
            radius: 60,
            showTitle: false,
          ),
        )
        .toList();
  }

  List<Widget> _buildPaymentMethodDetails(
      Map<String, double> paymentMethodsTotals) {
    double total = paymentMethodsTotals.values.fold(0, (a, b) => a + b);

    return paymentMethodsTotals.entries.map((e) {
      double percentage = (e.value / total) * 100;
      return DailyIncomePaymentMethodDetails(
        color: _getColorByMethod(e.key),
        method: e.key,
        percentage: percentage,
        total: AppFormaters.getFormattedTotal(e.value),
      );
    }).toList();
  }
}
