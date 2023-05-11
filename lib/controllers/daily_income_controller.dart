import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import '../models/daily_income.dart';
import '../utils/interfaces/daily_income_repository.dart';

class DailyIncomeController {
  final Logger _logger;

  final DailyIncomeRepository _repository;

  final _incomes = BehaviorSubject<List<DailyIncome>>();

  DailyIncomeController(this._logger, this._repository) {
    _load();
  }

  Stream<List<DailyIncome>> get incomes => _incomes.stream;

  void _load() {
    _logger.info('Loading incomes');
    _repository.getAll().listen(
      (data) => _incomes.add(data),
      onError: (err) {
        _logger.severe('Error loading incomes: $err');
        _incomes.addError(err);
      },
    );
    _logger.info('Incomes loaded');
  }

  Future<void> add(DailyIncome income) async {
    _logger.info('Adding income');
    try {
      await _repository.add(
        income.copyWith(
          createdBy: 'notImplemented',
          modifiedBy: 'notImplemented',
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now(),
          total: income.calculateTotal(),
        ),
      );
      _logger.info('Income added');
    } catch (e) {
      _logger.severe('Error adding income: $e');
      rethrow;
    }
  }

  Future<void> update(DailyIncome income) async {
    _logger.info('Updating income');
    try {
      await _repository.update(
        income.copyWith(
          modifiedBy: 'notImplemented',
          modifiedAt: DateTime.now(),
          total: income.calculateTotal(),
        ),
      );
      _logger.info('Income updated');
    } catch (e) {
      _logger.severe('Error updating income: $e');
      rethrow;
    }
  }

  Future<void> delete(DailyIncome income) async {
    _logger.info('Deleting income');
    try {
      await _repository.delete(income);
      _logger.info('Income deleted');
    } catch (e) {
      _logger.severe('Error deleting income: $e');
      rethrow;
    }
  }

  void dispose() {
    _logger.info('Disposing DailyIncomeController');
    _incomes.close();
  }
}
