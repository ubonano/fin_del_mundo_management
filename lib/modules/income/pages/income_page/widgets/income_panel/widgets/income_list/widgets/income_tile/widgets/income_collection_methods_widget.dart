import 'package:flutter/material.dart';

import '../../../../../../../../../income.dart';

class IncomeCollectionMethodsWidgets extends StatelessWidget {
  final Income income;

  const IncomeCollectionMethodsWidgets({Key? key, required this.income})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPayment = income.total;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: income.collectionItems.map(
        (entry) {
          final percentage =
              ((entry.amount / totalPayment) * 100).toStringAsFixed(2);

          return Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  entry.getIcon(),
                  size: 25,
                  color: entry.getColor(),
                ),
                Text(
                  '($percentage%)',
                  style: TextStyle(
                    fontSize: 12,
                    color: entry.getColor(),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  // Color _getPaymentMethodColor(String paymentMethod) {
  //   switch (paymentMethod) {
  //     case 'cash':
  //       return Colors.green;
  //     case 'cards':
  //       return Colors.orange;
  //     case 'mercadoPago':
  //       return Colors.blue;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // IconData _getPaymentMethodIcon(String paymentMethod) {
  //   switch (paymentMethod) {
  //     case 'cash':
  //       return Icons.wallet;
  //     case 'cards':
  //       return Icons.credit_card;
  //     case 'mercadoPago':
  //       return Icons.handshake;
  //     default:
  //       return Icons.payment;
  //   }
  // }
}
