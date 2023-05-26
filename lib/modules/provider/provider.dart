import 'package:cloud_firestore/cloud_firestore.dart';

import '../user/user.dart';

class Provider {
  String id;
  String name;
  String phoneNumber;
  String email;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  Provider({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory Provider.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Provider(
      id: doc.id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      createdBy: User.fromFirestore(data['createdBy']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User.fromFirestore(data['modifiedBy']),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'createdBy': createdBy.toFirestore(),
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.toFirestore(),
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };
}
