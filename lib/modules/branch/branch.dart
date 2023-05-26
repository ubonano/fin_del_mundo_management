import 'package:cloud_firestore/cloud_firestore.dart';

import '../user/user.dart';

class Branch {
  String id;
  String name;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  factory Branch.all() {
    return Branch(
      id: 'CEUw1jAKFc4IBG6v4mou', // 'all'
      name: 'Restaurante', // 'Todas'
      createdAt: DateTime.now(),
      createdBy: User.empty(),
      modifiedBy: User.empty(),
      modifiedAt: DateTime.now(),
    );
  }

  factory Branch.empty({required String id, required String name}) {
    return Branch(
      id: id,
      name: name,
      createdAt: DateTime.now(),
      createdBy: User.empty(),
      modifiedBy: User.empty(),
      modifiedAt: DateTime.now(),
    );
  }

  Branch({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
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
      createdBy: User(
        id: data['createdBy'],
        name: data['createdBy'],
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User(
        id: data['modifiedBy'],
        name: data['modifiedBy'],
      ),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'createdBy': createdBy.id,
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.id,
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };

  @override
  String toString() {
    return name;
  }
}
