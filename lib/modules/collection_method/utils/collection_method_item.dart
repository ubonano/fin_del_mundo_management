import 'package:flutter/material.dart';

class CollectionMethodItem {
  String name;
  double amount;

  CollectionMethodItem({
    required this.name,
    this.amount = 0.0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionMethodItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  factory CollectionMethodItem.fromMap(Map<String, dynamic> map) {
    return CollectionMethodItem(
      name: map['name'],
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

    return methodsColors[name] ?? Colors.grey;
  }

  IconData getIcon() {
    switch (name) {
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
