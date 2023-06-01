import 'package:flutter/material.dart';
import '../../../../collection_method/helpers/collection_item.dart';

class IncomeCollectionMethodDetails extends StatelessWidget {
  final double percentage;
  final String total;
  final CollectionItem collectionMethod;

  const IncomeCollectionMethodDetails({
    super.key,
    required this.percentage,
    required this.total,
    required this.collectionMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.circle, size: 16, color: collectionMethod.getColor()),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            collectionMethod.name,
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
