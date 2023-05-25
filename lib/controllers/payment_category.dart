import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import '../models/payment_category.dart';
import '../utils/interfaces/payment_category_repository.dart';

class PaymentCategoryController {
  final Logger _logger;
  final PaymentCategoryRepository _repository;

  final _paymentCategoriesController = BehaviorSubject<List<PaymentCategory>>();

  PaymentCategoryController(this._logger, this._repository) {
    _load();
  }

  Stream<List<PaymentCategory>> get paymentCategories =>
      _paymentCategoriesController.stream;

  void _load() {
    _logger.info('Loading payment categories...');
    _repository.getAll().listen(
      (paymentCategories) {
        _paymentCategoriesController.add(paymentCategories);
        _logger.info('Loaded ${paymentCategories.length} payment categories.');
      },
      onError: (error) {
        _logger.severe('Failed to load payment categories: $error');
      },
    );
  }

  Future<void> add(PaymentCategory paymentCategory) async {
    _logger.info('Adding payment category: ${paymentCategory.name}...');
    try {
      await _repository.add(paymentCategory);
      _logger.info('Added payment category: ${paymentCategory.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add payment category: $error');
    }
  }

  Future<void> update(PaymentCategory paymentCategory) async {
    _logger.info('Updating payment category: ${paymentCategory.id}...');
    try {
      await _repository.update(paymentCategory);
      _logger.info('Updated payment category: ${paymentCategory.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update payment category: $error');
    }
  }

  Future<void> delete(PaymentCategory paymentCategory) async {
    _logger.info('Deleting payment category: ${paymentCategory.id}...');
    try {
      await _repository.delete(paymentCategory);
      _logger.info('Deleted payment category: ${paymentCategory.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete payment category: $error');
    }
  }

  void dispose() {
    _paymentCategoriesController.close();
  }
}
