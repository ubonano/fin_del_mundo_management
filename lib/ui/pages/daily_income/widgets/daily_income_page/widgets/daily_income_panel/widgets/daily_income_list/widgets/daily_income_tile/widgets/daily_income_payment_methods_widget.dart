import 'package:flutter/material.dart';

import '../../../../../../../../../../../../models/daily_income.dart';

class DailyIncomePaymentMethodsWidgets extends StatelessWidget {
  final DailyIncome income;

  const DailyIncomePaymentMethodsWidgets({Key? key, required this.income})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPayment = income.calculateTotal();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: income.paymentMethods.entries.map(
        (entry) {
          final percentage =
              ((entry.value / totalPayment) * 100).toStringAsFixed(2);

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  _getPaymentMethodIcon(entry.key),
                  size: 25,
                  color: _getPaymentMethodColor(entry.key),
                ),
                Text(
                  '($percentage%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: _getPaymentMethodColor(entry.key),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  Color _getPaymentMethodColor(String paymentMethod) {
    switch (paymentMethod) {
      case 'cash':
        return Colors.green;
      case 'cards':
        return Colors.orange;
      case 'mercadoPago':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod) {
      case 'cash':
        return Icons.wallet;
      case 'cards':
        return Icons.credit_card;
      case 'mercadoPago':
        return Icons.handshake;
      default:
        return Icons.payment;
    }
  }
}
