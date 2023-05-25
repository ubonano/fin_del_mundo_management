import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';

class Employee {
  String id;
  String fullName;
  String idNumber;
  String phoneNumber;
  String email;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  Employee({
    required this.id,
    required this.fullName,
    required this.idNumber,
    required this.phoneNumber,
    required this.email,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory Employee.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Employee(
      id: doc.id,
      fullName: data['fullName'],
      idNumber: data['idNumber'],
      phoneNumber: data['phoneNumber'],
      email: data['email'],
      createdBy: User.fromFirestore(data['createdBy']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User.fromFirestore(data['modifiedBy']),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'fullName': fullName,
        'idNumber': idNumber,
        'phoneNumber': phoneNumber,
        'email': email,
        'createdBy': createdBy.toFirestore(),
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.toFirestore(),
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };
}
