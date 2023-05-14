import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import '../models/daily_income.dart';
import '../utils/interfaces/daily_income_repository.dart';

class DailyIncomeController {
  final Logger _logger;

  final DailyIncomeRepository _repository;

  final _incomes = BehaviorSubject<List<DailyIncome>>();
  final _selectedBranch = BehaviorSubject<String>.seeded('Restaurante');
  late final _selectedMonth = BehaviorSubject<String>.seeded(_currentMonth());

  DailyIncomeController(this._logger, this._repository) {
    initializeDateFormatting('es_ES', null);
    _load();
  }

  Stream<List<DailyIncome>> get incomes => _incomes.stream;
  Stream<String> get selectedBranch => _selectedBranch.stream;
  Stream<String> get selectedMonth => _selectedMonth.stream;

  void filterByBranch(String branch) {
    _selectedBranch.add(branch);
  }

  void filterByMonth(String month) {
    _selectedMonth.add(month);
  }

  void _load() {
    _logger.info('Loading incomes');

    Rx.combineLatest3<List<DailyIncome>, String, String, List<DailyIncome>>(
      _repository.getAll(),
      _selectedBranch.stream,
      _selectedMonth.stream,
      (data, selectedBranch, selectedMonth) {
        data.sort((a, b) => b.date.compareTo(a.date)); // Descending order.

        return data.where((income) {
          bool matchesBranch =
              selectedBranch == 'All' || income.branch == selectedBranch;
          bool matchesMonth =
              DateFormat.MMMM('es_ES').format(income.date) == selectedMonth;

          return matchesBranch && matchesMonth;
        }).toList();
      },
    ).listen(
      (filteredData) {
        _incomes.add(filteredData);
      },
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
    _logger.info('Updating income with ID: ${income.id}');
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
      _logger.severe('Error updating income with ID: ${income.id}: $e');
      rethrow;
    }
  }

  Future<void> delete(DailyIncome income) async {
    _logger.info('Deleting income with ID: ${income.id}');
    try {
      await _repository.delete(income);
      _logger.info('Income deleted');
    } catch (e) {
      _logger.severe('Error deleting income with ID: ${income.id}: $e');
      rethrow;
    }
  }

  //TODO llevar estos metodos a una clase aparte.
  //
  static String _currentMonth() {
    DateTime now = DateTime.now();
    return DateFormat.MMMM('es_ES').format(now);
  }

  List<String> generateAllMonths() {
    final months = <String>[];

    for (int i = 1; i <= 12; i++) {
      final date = DateTime(DateTime.now().year, i);
      final monthName = DateFormat.MMMM('es_ES').format(date);
      months.add(monthName);
    }

    return months;
  }

  void dispose() {
    _logger.info('Disposing DailyIncomeController');
    _incomes.close();
  }
}
