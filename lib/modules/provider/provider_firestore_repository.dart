import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import 'provider.dart';
import 'provider_repository.dart';

class ProviderFirestoreRepository implements ProviderRepository {
  final Logger _logger;
  final CollectionReference _collection;

  ProviderFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('providers');

  @override
  Stream<List<Provider>> getAll() {
    _logger.info('Fetching providers...');
    return _collection.snapshots().map(
      (snapshot) {
        final providers =
            snapshot.docs.map((doc) => Provider.fromFirestore(doc)).toList();
        _logger.info('Finished fetching all providers');
        return providers;
      },
    );
  }

  @override
  Future<void> add(Provider provider) async {
    _logger.info('Adding provider: ${provider.name}...');
    await _collection
        .add(provider.toFirestore())
        .then((value) => _logger.info('Successfully added a provider'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a provider: $error');
        throw error;
      },
    );
    _logger.info('Added provider: ${provider.name}.');
  }

  @override
  Future<void> update(Provider provider) async {
    _logger.info('Updating provider with id: ${provider.id}...');
    await _collection.doc(provider.id).update(provider.toFirestore()).then(
      (value) {
        _logger
            .info('Successfully updated a provider with ID: [${provider.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a provider with ID: [${provider.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated provider with id: ${provider.id}.');
  }

  @override
  Future<void> delete(Provider provider) async {
    _logger.info('Deleting provider with id: ${provider.id}...');
    await _collection
        .doc(provider.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a provider'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a provider with ID: [${provider.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted provider with id: ${provider.id}.');
  }
}
