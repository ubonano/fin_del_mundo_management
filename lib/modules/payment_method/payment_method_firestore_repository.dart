import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'payment_method.dart';
import 'payment_method_repository.dart';

class PaymentMethodFirestoreRepository implements PaymentMethodRepository {
  final Logger _logger;
  final CollectionReference _collection;

  PaymentMethodFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('paymentMethods');

  @override
  Stream<List<PaymentMethod>> getAll() {
    _logger.info('Fetching payment methods...');
    return _collection.snapshots().map(
      (snapshot) {
        final paymentMethods = snapshot.docs
            .map((doc) => PaymentMethod.fromFirestore(doc))
            .toList();
        _logger.info('Finished fetching all payment methods');
        return paymentMethods;
      },
    );
  }

  @override
  Future<void> add(PaymentMethod method) async {
    _logger.info('Adding payment method: ${method.name}...');
    await _collection
        .add(method.toFirestore())
        .then((value) => _logger.info('Successfully added a payment method'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a payment method: $error');
        throw error;
      },
    );
    _logger.info('Added payment method: ${method.name}.');
  }

  @override
  Future<void> update(PaymentMethod method) async {
    _logger.info('Updating payment method with id: ${method.id}...');
    await _collection.doc(method.id).update(method.toFirestore()).then(
      (value) {
        _logger.info(
            'Successfully updated a payment method with ID: [${method.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a payment method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated payment method with id: ${method.id}.');
  }

  @override
  Future<void> delete(PaymentMethod method) async {
    _logger.info('Deleting payment method with id: ${method.id}...');
    await _collection
        .doc(method.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a payment method'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a payment method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted payment method with id: ${method.id}.');
  }
}
