import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'income_method.dart';
import 'helpers/income_method_repository.dart';

class IncomeMethodController {
  final Logger _logger;
  final IncomeMethodRepository _repository;

  final _methods = BehaviorSubject<List<IncomeMethod>>();

  IncomeMethodController(this._logger, this._repository) {
    _load();
  }

  Stream<List<IncomeMethod>> get $incomeMethods => _methods.stream;

  void _load() {
    _logger.info('Loading income methods...');
    _repository.getAll().listen(
      (incomeMethods) {
        _methods.add(incomeMethods);
        _logger.info('Loaded ${incomeMethods.length} income methods.');
      },
      onError: (error) {
        _logger.severe('Failed to load income methods: $error');
      },
    );
  }

  Future<void> add(IncomeMethod method) async {
    _logger.info('Adding income method: ${method.name}...');
    try {
      await _repository.add(method);
      _logger.info('Added income method: ${method.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add income method: $error');
    }
  }

  Future<void> updateCollectionMethod(IncomeMethod method) async {
    _logger.info('Updating income method: ${method.id}...');
    try {
      await _repository.update(method);
      _logger.info('Updated income method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update income method: $error');
    }
  }

  Future<void> delete(IncomeMethod method) async {
    _logger.info('Deleting income method: ${method.id}...');
    try {
      await _repository.delete(method);
      _logger.info('Deleted income method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete income method: $error');
    }
  }

  void dispose() {
    _methods.close();
  }
}
