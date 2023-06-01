import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'provider.dart';
import 'helpers/provider_repository.dart';

class ProviderController {
  final Logger _logger;
  final ProviderRepository _repository;

  final _providersController = BehaviorSubject<List<Provider>>();

  ProviderController(this._logger, this._repository) {
    _load();
  }

  Stream<List<Provider>> get providers => _providersController.stream;

  void _load() {
    _logger.info('Loading providers...');
    _repository.getAll().listen(
      (providers) {
        _providersController.add(providers);
        _logger.info('Loaded ${providers.length} providers.');
      },
      onError: (error) {
        _logger.severe('Failed to load providers: $error');
      },
    );
  }

  Future<void> add(Provider provider) async {
    _logger.info('Adding provider: ${provider.name}...');
    try {
      await _repository.add(provider);
      _logger.info('Added provider: ${provider.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add provider: $error');
    }
  }

  Future<void> update(Provider provider) async {
    _logger.info('Updating provider: ${provider.id}...');
    try {
      await _repository.update(provider);
      _logger.info('Updated provider: ${provider.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update provider: $error');
    }
  }

  Future<void> delete(Provider provider) async {
    _logger.info('Deleting provider: ${provider.id}...');
    try {
      await _repository.delete(provider);
      _logger.info('Deleted provider: ${provider.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete provider: $error');
    }
  }

  void dispose() {
    _providersController.close();
  }
}
