import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;

  PaymentMethod({required this.id, required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethod && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory PaymentMethod.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaymentMethod(
      id: doc.id,
      name: data['name'],
    );
  }

  Color getColor() {
    Map<String, Color> methodsColors = {
      'cash': Colors.green,
      'cards': Colors.orange,
      'mercadoPago': Colors.lightBlue,
      'paymentMethodNotImplemented*': Colors.grey,
    };

    return methodsColors[this.name] ?? Colors.grey;
  }

  String getLabel() {
    Map<String, String> methodsLabels = {
      'cash': 'Efectivo',
      'cards': 'Tarjetas',
      'mercadoPago': 'Mercado Pago',
    };

    return methodsLabels[name] ?? 'paymentMethodNotImplemented*';
  }
}
