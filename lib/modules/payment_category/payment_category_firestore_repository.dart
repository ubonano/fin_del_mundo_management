import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/modules/payment_category/payment_category.dart';
import 'package:logging/logging.dart';
import 'payment_category_repository.dart';

class PaymentCategoryFirestoreRepository implements PaymentCategoryRepository {
  final Logger _logger;
  final CollectionReference _collection;

  PaymentCategoryFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('paymentCategories');

  @override
  Stream<List<PaymentCategory>> getAll() {
    _logger.info('Fetching payment categories...');
    return _collection.snapshots().map(
      (snapshot) {
        final paymentCategories = snapshot.docs
            .map((doc) => PaymentCategory.fromFirestore(doc))
            .toList();
        _logger.info('Finished fetching all payment categories');
        return paymentCategories;
      },
    );
  }

  @override
  Future<void> add(PaymentCategory paymentCategory) async {
    _logger.info('Adding payment categories: ${paymentCategory.name}...');
    await _collection
        .add(paymentCategory.toFirestore())
        .then(
            (value) => _logger.info('Successfully added an payment categories'))
        .catchError(
      (error) {
        _logger.severe('Failed to add an payment categories: $error');
        throw error;
      },
    );
    _logger.info('Added payment categories: ${paymentCategory.name}.');
  }

  @override
  Future<void> update(PaymentCategory paymentCategory) async {
    _logger
        .info('Updating payment categories with id: ${paymentCategory.id}...');
    await _collection
        .doc(paymentCategory.id)
        .update(paymentCategory.toFirestore())
        .then(
      (value) {
        _logger.info(
            'Successfully updated an payment categories with ID: [${paymentCategory.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update an payment categories with ID: [${paymentCategory.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated payment categories with id: ${paymentCategory.id}.');
  }

  @override
  Future<void> delete(PaymentCategory paymentCategory) async {
    _logger
        .info('Deleting payment categories with id: ${paymentCategory.id}...');
    await _collection
        .doc(paymentCategory.id)
        .delete()
        .then(
            (value) => _logger.info('Successfully deleted an payment category'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete an payment categories with ID: [${paymentCategory.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted payment categories with id: ${paymentCategory.id}.');
  }
}
