import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../user/user.dart';

class PaymentMethod {
  final String id;
  final String name;
  final User createdBy;
  final DateTime createdAt;
  final User modifiedBy;
  final DateTime modifiedAt;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethod && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'createdBy': createdBy.toFirestore(),
      'createdAt': Timestamp.fromDate(createdAt),
      'modifiedBy': modifiedBy.toFirestore(),
      'modifiedAt': Timestamp.fromDate(modifiedAt),
    };
  }

  factory PaymentMethod.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PaymentMethod(
      id: doc.id,
      name: data['name'],
      createdBy: User.fromFirestore(data['createdBy']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User.fromFirestore(data['modifiedBy']),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
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
