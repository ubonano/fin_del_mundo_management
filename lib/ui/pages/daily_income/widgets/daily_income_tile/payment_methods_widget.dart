import 'package:flutter/material.dart';

import '../../../../../models/daily_income.dart';

class PaymentMethodsWidgets extends StatelessWidget {
  final DailyIncome income;

  const PaymentMethodsWidgets({Key? key, required this.income})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPayment = income.calculateTotal();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: income.paymentMethods.entries.map((entry) {
        final percentage =
            ((entry.value / totalPayment) * 100).toStringAsFixed(2);

        return Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getPaymentMethodIcon(entry.key),
              _getPaymentMethodPercent(entry.key, percentage),
            ],
          ),
        );
      }).toList(),
    );
  }

  Text _getPaymentMethodPercent(String paymentMethod, String percentage) {
    TextStyle style;
    switch (paymentMethod) {
      case 'cash':
        style = const TextStyle(fontSize: 12, color: Colors.green);
        break;
      case 'cards':
        style = const TextStyle(fontSize: 12, color: Colors.orange);
        break;
      case 'mercadoPago':
        style = const TextStyle(fontSize: 12, color: Colors.blue);
        break;
      default:
        style = const TextStyle(fontSize: 12, color: Colors.grey);
        break;
    }

    return Text('($percentage%)', style: style);
  }

  Icon _getPaymentMethodIcon(String paymentMethod) {
    switch (paymentMethod) {
      case 'cash':
        return const Icon(Icons.wallet, size: 25, color: Colors.green);
      case 'cards':
        return const Icon(Icons.credit_card, size: 25, color: Colors.orange);
      case 'mercadoPago':
        return const Icon(Icons.handshake, size: 25, color: Colors.blue);
      default:
        return const Icon(Icons.payment, size: 25, color: Colors.grey);
    }
  }
}
