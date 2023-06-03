import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import '../payment_category/payment_category.dart';
import '../payment_method/payment_method.dart';

class Payment {
  String id;
  DateTime date;
  Branch branch;
  PaymentCategory category;
  PaymentMethod method;
  String beneficiaryId;
  String status;
  DateTime paymentDate;

  Payment({
    required this.id,
    required this.date,
    required this.branch,
    required this.category,
    required this.method,
    required this.beneficiaryId,
    required this.status,
    required this.paymentDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Payment && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Payment(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(
        id: data['branchId'],
        name: data['branchName'],
      ),
      category: PaymentCategory(
        id: data['paymentCategoryId'],
        name: data['paymentCategoryName'],
      ),
      method: PaymentMethod(
        id: data['paymentMethodId'],
        name: data['paymentMethodName'],
      ),
      beneficiaryId: data['beneficiary'],
      status: data['status'],
      paymentDate: (data['paymentDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'paymentCategoryId': category.id,
        'paymentCategoryName': category.name,
        'paymentMethodId': method.id,
        'paymentMethodName': method.name,
        'beneficiary': beneficiaryId,
        'status': status,
        'paymentDate': Timestamp.fromDate(paymentDate),
      };
}
