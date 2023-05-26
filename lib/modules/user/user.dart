import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;

  User({required this.id, required this.name});

  factory User.empty() {
    return User(id: 'system', name: 'System');
  }

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return User(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };
}
