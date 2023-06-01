import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethod {
  final String id;
  final String name;

  PaymentMethod({
    required this.id,
    required this.name,
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
    };
  }

  factory PaymentMethod.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PaymentMethod(
      id: doc.id,
      name: data['name'],
    );
  }
}
