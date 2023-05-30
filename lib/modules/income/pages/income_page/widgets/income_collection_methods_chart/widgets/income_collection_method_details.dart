import 'package:fin_del_mundo_management/modules/payment_method/payment_method.dart';
import 'package:flutter/material.dart';

class IncomeCollectionMethodDetails extends StatelessWidget {
  final double percentage;
  final String total;
  final PaymentMethod paymentMethod;

  const IncomeCollectionMethodDetails({
    super.key,
    required this.percentage,
    required this.total,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 16, color: paymentMethod.getColor()),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            paymentMethod.getLabel(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${percentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '\$$total',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
