import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/modules/user/user.dart';

class PaymentCategory {
  String id;
  String name;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  PaymentCategory(
      {required this.id,
      required this.name,
      required this.createdBy,
      required this.createdAt,
      required this.modifiedBy,
      required this.modifiedAt});

  factory PaymentCategory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PaymentCategory(
      id: doc.id,
      name: data['name'],
      createdBy: User.fromFirestore(data['createdBy']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User.fromFirestore(data['modifiedBy']),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'createdBy': createdBy.toFirestore(),
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.toFirestore(),
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };
}
