import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import '../models/collection_method.dart';
import '../utils/interfaces/collection_method_repository.dart';

class FirestoreCollectionMethodRepository
    implements CollectionMethodRepository {
  final Logger _logger;
  final CollectionReference _collection;

  FirestoreCollectionMethodRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('collectionMethods');

  @override
  Stream<List<CollectionMethod>> getAll() {
    _logger.info('Fetching collection methods...');
    return _collection.snapshots().map(
      (snapshot) {
        final collectionMethods = snapshot.docs
            .map((doc) => CollectionMethod.fromFirestore(doc))
            .toList();
        _logger.info('Finished fetching all collection methods');
        return collectionMethods;
      },
    );
  }

  @override
  Future<void> add(CollectionMethod method) async {
    _logger.info('Adding collection method: ${method.name}...');
    await _collection
        .add(method.toFirestore())
        .then((value) => _logger.info('Successfully added a colection method'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a collection method: $error');
        throw error;
      },
    );
    _logger.info('Added collection method: ${method.name}.');
  }

  @override
  Future<void> update(CollectionMethod method) async {
    _logger.info('Updating collection method with id: ${method.id}...');
    await _collection.doc(method.id).update(method.toFirestore()).then(
      (value) {
        _logger.info(
            'Successfully updated a collection method with ID: [${method.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a collection method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated collection method with id: ${method.id}.');
  }

  @override
  Future<void> delete(CollectionMethod method) async {
    _logger.info('Deleting collection method with id: ${method.id}...');
    await _collection
        .doc(method.id)
        .delete()
        .then(
            (value) => _logger.info('Successfully deleted a collection method'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a collection method with ID: [${method.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted collection method with id: ${method.id}.');
  }
}
