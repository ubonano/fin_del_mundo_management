import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import 'payment.dart';
import 'helpers/payment_repository.dart';

class PaymentFirestoreRepository implements PaymentRepository {
  final CollectionReference _collection;

  PaymentFirestoreRepository(FirebaseFirestore instance)
      : _collection = instance.collection('payments');

  @override
  Stream<List<Payment>> getAll() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Payment.fromFirestore(doc)).toList());
  }

  @override
  Stream<List<Payment>> getByMonthAndYear(int month, int year) {
    final startDate = DateTime(year, month);
    final endDate = DateTime(year, month + 1);

    return _collection
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: endDate)
        .snapshots()
        .map(
          (query) =>
              query.docs.map((doc) => Payment.fromFirestore(doc)).toList(),
        );
  }

  @override
  Stream<List<Payment>> getByDateAndBranch(DateTime date, Branch branch) {
    final nextDay = DateTime(date.year, date.month, date.day + 1);

    return _collection
        .where('date', isGreaterThanOrEqualTo: date, isLessThan: nextDay)
        .where('branchId', isEqualTo: branch.id)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => Payment.fromFirestore(doc)).toList());
  }

  @override
  Future<void> add(Payment payment) async {
    await _collection.add(payment.toFirestore());
  }

  @override
  Future<void> update(Payment payment) async {
    await _collection.doc(payment.id).update(payment.toFirestore());
  }

  @override
  Future<void> delete(Payment payment) async {
    await _collection.doc(payment.id).delete();
  }
}
