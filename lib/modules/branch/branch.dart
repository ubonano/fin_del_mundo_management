import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  String id;
  String name;

  factory Branch.all() {
    return Branch(
      id: 'VHoSIo5jxIcUVbfsEVcv', // 'all'
      name: 'Restaurante', // 'Todas'
    );
  }

  Branch({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Branch &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  factory Branch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Branch(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };

  @override
  String toString() {
    return name;
  }
}
