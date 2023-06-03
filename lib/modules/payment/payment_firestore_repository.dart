import 'package:cloud_firestore/cloud_firestore.dart';
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
