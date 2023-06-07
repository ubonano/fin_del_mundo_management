import 'package:fin_del_mundo_management/modules/payment_category/payment_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import '../../utils/app_date_time.dart';
import '../branch/branch.dart';
import '../../widgets/app_common_filters/common_filters_controller.dart';
import '../payment_method/payment_method.dart';
import 'payment.dart';
import 'helpers/payment_repository.dart';

class PaymentController {
  final Logger _logger;

  final PaymentRepository _repository;
  final CommonFiltersController _filtersController;

  final _payments = BehaviorSubject<List<Payment>>();
  final _totalPayment = BehaviorSubject<double>.seeded(0);

  Stream<Branch> get $selectedBranch => _filtersController.$selectedBranch;
  Stream<String> get $selectedMonth => _filtersController.$selectedMonth;
  Stream<String> get $selectedYear => _filtersController.$selectedYear;

  Branch get selectedBranch => _filtersController.selectedBranch;
  String get selectedMonth => _filtersController.selectedMonth;
  String get selectedYear => _filtersController.selectedYear;

  PaymentController(this._logger, this._repository, this._filtersController) {
    _load();
  }

  Stream<List<Payment>> get $payments => _payments.stream;
  Stream<double> get $totalPayment => _totalPayment.stream;

  void _load() {
    _logger.info('Loading payments...');
    _repository.getAll().listen(
      (payments) {
        _payments.add(payments);
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

  List<Payment> fillPaymentsForCurrentMonth() {
    final year = int.parse(selectedYear);
    final month = AppDateTime.monthNameToNumber(selectedMonth);

    int daysInMonth = DateTime(year, month + 1, 0).day;

    List<Payment> dailyIncomesForMonth = [];

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime currentDate = DateTime(year, month, i);

      var incomeForCurrentDate = _payments.value.firstWhere(
        (payment) => payment.date.day == currentDate.day,
        orElse: () => Payment(
          id: '',
          date: currentDate,
          branch: Branch(id: '', name: ''),
          beneficiaryId: '',
          beneficiaryName: '',
          category: PaymentCategory(id: '', name: ''),
          method: PaymentMethod(id: '', name: ''),
          paymentDate: DateTime.now(),
          status: '',
        ),
      );
      dailyIncomesForMonth.add(incomeForCurrentDate);
    }

    return dailyIncomesForMonth;
  }

  Map<PaymentCategory, double> calculateCategoryTotals() {
    Map<PaymentCategory, double> categoryTotals = {};

    for (var payment in _payments.value) {
      categoryTotals.update(
        payment.category,
        (value) => value + payment.total,
        ifAbsent: () => payment.total,
      );
    }
    return categoryTotals;
  }

  void dispose() {
    _logger.info('Disposing PaymentController');
    _payments.close();
    _totalPayment.close();
  }
}
