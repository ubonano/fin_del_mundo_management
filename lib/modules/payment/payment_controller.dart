import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'payment.dart';
import 'payment_repository.dart';

class PaymentController {
  final Logger _logger;
  final PaymentRepository _repository;

  final _paymentsController = BehaviorSubject<List<Payment>>();

  PaymentController(this._logger, this._repository) {
    _load();
  }

  Stream<List<Payment>> get payments => _paymentsController.stream;

  void _load() {
    _logger.info('Loading payments...');
    _repository.getAll().listen(
      (payments) {
        _paymentsController.add(payments);
        _logger.info('Loaded ${payments.length} payments.');
      },
      onError: (error) {
        _logger.severe('Failed to load payments: $error');
      },
    );
  }

  Future<void> add(Payment payment) async {
    _logger.info('Adding payment...');
    try {
      await _repository.add(payment);
      _logger.info('Added payment.');
    } catch (error) {
      _logger.severe('Failed to add payment: $error');
    }
  }

  Future<void> update(Payment payment) async {
    _logger.info('Updating payment: ${payment.id}...');
    try {
      await _repository.update(payment);
      _logger.info('Updated payment: ${payment.id}.');
    } catch (error) {
      _logger.severe('Failed to update payment: $error');
    }
  }

  Future<void> delete(Payment payment) async {
    _logger.info('Deleting payment: ${payment.id}...');
    try {
      await _repository.delete(payment);
      _logger.info('Deleted payment: ${payment.id}.');
    } catch (error) {
      _logger.severe('Failed to delete payment: $error');
    }
  }

  void dispose() {
    _paymentsController.close();
  }
}
