import 'package:flutter/material.dart';

class PaymentMethodDetails extends StatelessWidget {
  final Color color;
  final String method;
  final double percentage;
  final String total;

  const PaymentMethodDetails({
    super.key,
    required this.color,
    required this.method,
    required this.percentage,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            method,
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
