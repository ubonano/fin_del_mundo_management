import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionMethod {
  String id;
  String name;

  CollectionMethod({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  factory CollectionMethod.blank() => CollectionMethod(id: '', name: '');

  factory CollectionMethod.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return CollectionMethod(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };
}
