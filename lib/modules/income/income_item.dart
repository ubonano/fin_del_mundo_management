import 'package:flutter/material.dart';

class IncomeItem {
  String collectioMethodnName;
  String collectionMethodId;
  double amount;

  IncomeItem({
    required this.collectioMethodnName,
    required this.collectionMethodId,
    this.amount = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeItem &&
          runtimeType == other.runtimeType &&
          collectionMethodId == other.collectionMethodId;

  @override
  int get hashCode => collectionMethodId.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'collectionMethodId': collectionMethodId,
      'collectionMethodName': collectioMethodnName,
      'amount': amount,
    };
  }

  factory IncomeItem.fromMap(Map<String, dynamic> map) {
    return IncomeItem(
      collectionMethodId: map['collectionMethodId'],
      collectioMethodnName: map['collectionMethodName'],
      amount: map['amount'],
    );
  }

  Color getColor() {
    Map<String, Color> methodsColors = {
      'Efectivo': Colors.green,
      'Tarjetas': Colors.orange,
      'Mercado Pago': Colors.lightBlue,
      'paymentMethodNotImplemented*': Colors.grey,
    };

    return methodsColors[collectioMethodnName] ?? Colors.grey;
  }

  IconData getIcon() {
    switch (collectioMethodnName) {
      case 'Efectivo':
        return Icons.wallet;
      case 'Tarjetas':
        return Icons.credit_card;
      case 'Mercado Pago':
        return Icons.handshake;
      default:
        return Icons.payment;
    }
  }
}
