import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'payment_method.dart';
import 'helpers/payment_method_repository.dart';

class PaymentMethodController {
  final Logger _logger;
  final PaymentMethodRepository _repository;

  final _paymentMethodsController = BehaviorSubject<List<PaymentMethod>>();

  PaymentMethodController(this._logger, this._repository) {
    _load();
  }

  Stream<List<PaymentMethod>> get paymentMethods =>
      _paymentMethodsController.stream;

  void _load() {
    _logger.info('Loading payment methods...');
    _repository.getAll().listen(
      (paymentMethods) {
        _paymentMethodsController.add(paymentMethods);
        _logger.info('Loaded ${paymentMethods.length} payment methods.');
      },
      onError: (error) {
        _logger.severe('Failed to load payment methods: $error');
      },
    );
  }

  Future<void> add(PaymentMethod method) async {
    _logger.info('Adding payment method: ${method.name}...');
    try {
      await _repository.add(method);
      _logger.info('Added payment method: ${method.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add payment method: $error');
    }
  }

  Future<void> update(PaymentMethod method) async {
    _logger.info('Updating payment method: ${method.id}...');
    try {
      await _repository.update(method);
      _logger.info('Updated payment method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update payment method: $error');
    }
  }

  Future<void> delete(PaymentMethod method) async {
    _logger.info('Deleting payment method: ${method.id}...');
    try {
      await _repository.delete(method);
      _logger.info('Deleted payment method: ${method.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete payment method: $error');
    }
  }

  void dispose() {
    _paymentMethodsController.close();
  }
}
