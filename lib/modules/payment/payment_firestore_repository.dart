import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'payment.dart';
import 'payment_repository.dart';

class PaymentFirestoreRepository implements PaymentRepository {
  final Logger _logger;
  final CollectionReference _collection;

  PaymentFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('payments');

  @override
  Stream<List<Payment>> getAll() {
    _logger.info('Fetching payments...');
    return _collection.snapshots().map(
      (snapshot) {
        final payments =
            snapshot.docs.map((doc) => Payment.fromFirestore(doc)).toList();
        _logger.info('Finished fetching all payments');
        return payments;
      },
    );
  }

  @override
  Future<void> add(Payment payment) async {
    _logger.info('Adding payment...');
    await _collection
        .add(payment.toFirestore())
        .then((value) => _logger.info('Successfully added a payment'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a payment: $error');
        throw error;
      },
    );
    _logger.info('Added payment.');
  }

  @override
  Future<void> update(Payment payment) async {
    _logger.info('Updating payment with id: ${payment.id}...');
    await _collection.doc(payment.id).update(payment.toFirestore()).then(
      (value) {
        _logger.info('Successfully updated a payment with ID: [${payment.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a payment with ID: [${payment.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated payment with id: ${payment.id}.');
  }

  @override
  Future<void> delete(Payment payment) async {
    _logger.info('Deleting payment with id: ${payment.id}...');
    await _collection
        .doc(payment.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a payment'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a payment with ID: [${payment.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted payment with id: ${payment.id}.');
  }
}
