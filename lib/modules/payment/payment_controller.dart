import 'package:fin_del_mundo_management/modules/payment_category/payment_category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import '../../utils/app_date_time.dart';
import '../branch/branch.dart';
import '../payment_method/payment_method.dart';
import 'payment.dart';
import 'helpers/payment_repository.dart';

class PaymentController {
  final Logger _logger;

  final PaymentRepository _repository;

  final _payments = BehaviorSubject<List<Payment>>();
  final _selectedBranch = BehaviorSubject<Branch>.seeded(Branch.all());

  final _selectedMonth =
      BehaviorSubject<String>.seeded(AppDateTime.currentMonth());
  final _selectedYear =
      BehaviorSubject<String>.seeded(DateTime.now().year.toString());
  final _totalPayment = BehaviorSubject<double>.seeded(0);

  PaymentController(this._logger, this._repository) {
    _load();
  }

  Stream<List<Payment>> get payments => _payments.stream;
  Stream<Branch> get selectedBranch => _selectedBranch.stream;
  Stream<String> get selectedMonth => _selectedMonth.stream;
  Stream<String> get selectedYear => _selectedYear.stream;
  Stream<double> get totalDailyPayment => _totalPayment.stream;

  void filterByBranch(Branch branch) {
    _logger.info('Changing branch filter to ${branch.name}');
    _selectedBranch.add(branch);
  }

  void filterByMonth(String month) {
    _logger.info('Changing month filter to $month');
    _selectedMonth.add(month);
  }

  void filterByYear(String year) {
    _logger.info('Changing year filter to $year');
    _selectedYear.add(year);
  }

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
    final year = int.parse(_selectedYear.value);
    final month = AppDateTime.monthNameToNumber(_selectedMonth.value);

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
    _selectedBranch.close();
    _selectedYear.close();
    _selectedMonth.close();
    _totalPayment.close();
  }
}
