import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'income_method.dart';
import 'helpers/income_method_repository.dart';

class IncomeMethodFirestoreRepository implements IncomeMethodRepository {
  final Logger _logger;
  final CollectionReference _collection;

  IncomeMethodFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection(
            'collectionMethods'); // TODO Cambiar nombre de coleccion = incomeMethods

  @override
  Stream<List<IncomeMethod>> getAll() {
    _logger.info('Fetching income methods...');
    return _collection.snapshots().map(
      (snapshot) {
        final incomeMethods = snapshot.docs
            .map((doc) => IncomeMethod.fromFirestore(doc))
            .toList();
        _logger.info('Finished fetching all income methods');
        return incomeMethods;
      },
    );
  }

  @override
  Future<void> add(IncomeMethod method) async {
    _logger.info('Adding income method: ${method.name}...');
    await _collection
        .add(method.toFirestore())
        .then((value) => _logger.info('Successfully added a income method'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a income method: $error');
        throw error;
      },
    );
    _logger.info('Added income method: ${method.name}.');
  }

  @override
  Future<void> update(IncomeMethod method) async {
    _logger.info('Updating income method with id: ${method.id}...');
    await _collection.doc(method.id).update(method.toFirestore()).then(
      (value) {
        _logger.info(
            'Successfully updated a income method with ID: [${method.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a income method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated income method with id: ${method.id}.');
  }

  @override
  Future<void> delete(IncomeMethod method) async {
    _logger.info('Deleting income method with id: ${method.id}...');
    await _collection
        .doc(method.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a income method'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a income method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted income method with id: ${method.id}.');
  }
}
