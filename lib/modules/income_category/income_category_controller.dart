import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import 'income_category.dart';
import 'helpers/income_category_repository.dart';

class IncomeCategoryController {
  final Logger _logger;
  final IncomeCategoryRepository _repository;

  final _incomeCategoriesController = BehaviorSubject<List<IncomeCategory>>();

  IncomeCategoryController(this._logger, this._repository) {
    _load();
  }

  Stream<List<IncomeCategory>> get $incomeCategories =>
      _incomeCategoriesController.stream;

  void _load() {
    _logger.info('Loading income categories...');
    _repository.getAll().listen(
      (incomeCategories) {
        _incomeCategoriesController.add(incomeCategories);
        _logger.info('Loaded ${incomeCategories.length} income categories.');
      },
      onError: (error) {
        _logger.severe('Failed to load income categories: $error');
      },
    );
  }

  Future<void> add(IncomeCategory incomeCategory) async {
    _logger.info('Adding income category: ${incomeCategory.name}...');
    try {
      await _repository.add(incomeCategory);
      _logger.info('Added income category: ${incomeCategory.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add income category: $error');
    }
  }

  Future<void> update(IncomeCategory incomeCategory) async {
    _logger.info('Updating income category: ${incomeCategory.id}...');
    try {
      await _repository.update(incomeCategory);
      _logger.info('Updated income category: ${incomeCategory.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update income category: $error');
    }
  }

  Future<void> delete(IncomeCategory incomeCategory) async {
    _logger.info('Deleting income category: ${incomeCategory.id}...');
    try {
      await _repository.delete(incomeCategory);
      _logger.info('Deleted income category: ${incomeCategory.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete income category: $error');
    }
  }

  void dispose() {
    _incomeCategoriesController.close();
  }
}
