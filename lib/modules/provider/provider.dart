import 'package:cloud_firestore/cloud_firestore.dart';

class Provider {
  String id;
  String name;

  Provider({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Provider &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  factory Provider.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Provider(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };
}
