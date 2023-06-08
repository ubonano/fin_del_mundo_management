import 'package:fin_del_mundo_management/modules/collection_method/collection_method.dart';
import 'package:flutter/material.dart';

import '../income_category/income_category.dart';

class IncomeLine {
  TextEditingController? controller;

  int id;
  CollectionMethod method;
  double amount;
  IncomeCategory category;

  IncomeLine({
    required this.id,
    required this.method,
    required this.category,
    this.amount = 0.0,
    this.controller,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeLine && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => method.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'collectionMethodId': method.id,
      'collectionMethodName': method.name,
      'incomeCategoryId': category.id,
      'incomeCategoryName': category.name,
      'amount': amount,
    };
  }

  factory IncomeLine.fromMap(Map<String, dynamic> map) {
    return IncomeLine(
      id: 0,
      method: CollectionMethod(
        id: map['collectionMethodId'],
        name: map['collectionMethodName'],
      ),
      category: IncomeCategory(
        id: map['incomeCategoryId'],
        name: map['incomeCategoryName'],
      ),
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

    return methodsColors[method.name] ?? Colors.grey;
  }

  IconData getIcon() {
    switch (method.name) {
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
