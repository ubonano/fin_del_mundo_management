import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'collection_method.dart';
import 'helpers/collection_method_repository.dart';

class CollectionMethodController {
  final Logger _logger;
  final CollectionMethodRepository _repository;

  final _collectionMethods = BehaviorSubject<List<CollectionMethod>>();

  CollectionMethodController(this._logger, this._repository) {
    _load();
  }

  Stream<List<CollectionMethod>> get collectionMethods =>
      _collectionMethods.stream;

  void _load() {
    _logger.info('Loading collection methods...');
    _repository.getAll().listen(
      (collectionMethods) {
        _collectionMethods.add(collectionMethods);
        _logger.info('Loaded ${collectionMethods.length} collection methods.');
      },
      onError: (error) {
        _logger.severe('Failed to load collection methods: $error');
      },
    );
  }

  Future<void> add(CollectionMethod method) async {
    _logger.info('Adding collection method: ${method.name}...');
    try {
      await _repository.add(method);
      _logger.info('Added collection method: ${method.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add collection method: $error');
    }
  }

  Future<void> updateCollectionMethod(CollectionMethod method) async {
    _logger.info('Updating collection method: ${method.id}...');
    try {
      await _repository.update(method);
      _logger.info('Updated collection method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update collection method: $error');
    }
  }

  Future<void> delete(CollectionMethod method) async {
    _logger.info('Deleting collection method: ${method.id}...');
    try {
      await _repository.delete(method);
      _logger.info('Deleted collection method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete collection method: $error');
    }
  }

  void dispose() {
    _collectionMethods.close();
  }
}
