import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IncomeCategory {
  String id;
  String name;

  IncomeCategory({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  factory IncomeCategory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return IncomeCategory(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };

  Color getColor() {
    Map<String, Color> colors = {
      'Proveedores': Colors.red,
      'Empleados': Colors.blue,
      'paymentMethodNotImplemented*': Colors.grey,
    };

    return colors[name] ?? Colors.grey;
  }

  IconData getIcon() {
    switch (name) {
      case 'Proveedores':
        return Icons.local_shipping_rounded;
      case 'Empleados':
        return Icons.person;
      default:
        return Icons.category_sharp;
    }
  }
}
