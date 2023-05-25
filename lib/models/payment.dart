import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/branch/branch.dart';
import 'payment_category.dart';
import 'payment_method.dart';
import 'user.dart';

class Payment {
  String id;
  DateTime date;
  Branch branch;
  PaymentCategory category;
  String beneficiary;
  PaymentMethod method;
  String status;
  DateTime paymentDate;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  Payment({
    required this.id,
    required this.date,
    required this.branch,
    required this.category,
    required this.beneficiary,
    required this.method,
    required this.status,
    required this.paymentDate,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
  });

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Payment(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch.fromFirestore(data['branch']),
      category: PaymentCategory.fromFirestore(data['category']),
      beneficiary: data['beneficiary'],
      method: PaymentMethod.fromFirestore(data['method']),
      status: data['status'],
      paymentDate: (data['paymentDate'] as Timestamp).toDate(),
      createdBy: User.fromFirestore(data['createdBy']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: User.fromFirestore(data['modifiedBy']),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branch': branch.toFirestore(),
        'category': category.toFirestore(),
        'beneficiary': beneficiary,
        'method': method.toFirestore(),
        'status': status,
        'paymentDate': Timestamp.fromDate(paymentDate),
        'createdBy': createdBy.toFirestore(),
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.toFirestore(),
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };
}
