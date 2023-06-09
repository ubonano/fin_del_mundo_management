import 'package:fin_del_mundo_management/modules/branch/branch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import '../../widgets/app_common_filters/common_filters_controller.dart';
import 'income_line.dart';
import 'income.dart';
import '../../utils/app_date_time.dart';
import 'helpers/income_repository.dart';

class IncomeController {
  final Logger _logger;

  final IncomeRepository _repository;
  final CommonFiltersController _filtersController;

  final _incomes = BehaviorSubject<List<Income>>();

  final _totalIncome = BehaviorSubject<double>.seeded(0);

  IncomeController(this._logger, this._repository, this._filtersController) {
    _load();
  }

  Stream<List<Income>> get $incomes => _incomes.stream;
  Stream<double> get $totalIncome => _totalIncome.stream;

  Stream<Branch> get $selectedBranch => _filtersController.$selectedBranch;
  Stream<String> get $selectedMonth => _filtersController.$selectedMonth;
  Stream<String> get $selectedYear => _filtersController.$selectedYear;

  Branch get selectedBranch => _filtersController.selectedBranch;
  String get selectedMonth => _filtersController.selectedMonth;
  String get selectedYear => _filtersController.selectedYear;

  void _load() {
    _logger.info('Loading incomes');

    _filtersController.$combinedFilters.listen((selected) {
      final monthNumber = AppDateTime.monthNameToNumber(selected['month']!);
      final currentYear = int.parse(selected['year']!);
      final branch = selected['branch'] as Branch;

      _repository.getByMonthAndYear(monthNumber, currentYear).listen(
        (data) {
          data.sort((a, b) => b.date.compareTo(a.date)); // Descending order.

          List<Income> filteredData;

          // if (branch.name == Branch.all().name) {
          //   filteredData = data;
          // } else {
          filteredData =
              data.where((income) => income.branch.id == branch.id).toList();
          // }

          _totalIncome.add(filteredData.fold(
              0, (previousValue, income) => previousValue + income.total));

          _incomes.add(filteredData);
        },
        onError: (err) {
          _logger.severe('Error loading incomes: $err');
          _incomes.addError(err);
        },
      );
    });
    _logger.info('Incomes loaded');
  }

  Future<void> add(Income income) async {
    _logger.info('Adding income');
    try {
      List<Income> existingIncomes = await _repository
          .getByDateAndBranch(income.date, income.branch)
          .first;

      if (existingIncomes.isNotEmpty) {
        _logger.warning('Income for this date and branch already exists');
        throw Exception(
            'El ingreso diario para esta fecha y sucursal ya existe');
      }

      await _repository.add(
        income.copyWith(total: income.total),
      );
      _logger.info('Income added');
    } catch (e) {
      _logger.severe('Error adding income: $e');
      rethrow;
    }
  }

  Future<void> update(Income income) async {
    _logger.info('Updating income with ID: ${income.id}');
    try {
      List<Income> existingIncomes = await _repository
          .getByDateAndBranch(income.date, income.branch)
          .first;
      if (existingIncomes.isNotEmpty && existingIncomes[0].id != income.id) {
        _logger
            .warning('Another income for this date and branch already exists');
        throw Exception(
            'Another income for this date and branch already exists');
      }
      await _repository.update(
        income.copyWith(total: income.total),
      );
      _logger.info('Income updated');
    } catch (e) {
      _logger.severe('Error updating income with ID: ${income.id}: $e');
      rethrow;
    }
  }

  Future<void> delete(Income income) async {
    _logger.info('Deleting income with ID: ${income.id}');
    try {
      await _repository.delete(income);
      _logger.info('Income deleted');
    } catch (e) {
      _logger.severe('Error deleting income with ID: ${income.id}: $e');
      rethrow;
    }
  }

  List<Income> fillIncomesForCurrentMonth() {
    final year = int.parse(selectedYear);
    final month = AppDateTime.monthNameToNumber(selectedMonth);

    int daysInMonth = DateTime(year, month + 1, 0).day;

    List<Income> dailyIncomesForMonth = [];

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime currentDate = DateTime(year, month, i);

      var incomeForCurrentDate = _incomes.value.firstWhere(
        (income) => income.date.day == currentDate.day,
        orElse: () => Income(
          id: '',
          date: currentDate,
          branch: Branch(id: '', name: ''),
          lines: [],
        ),
      );
      dailyIncomesForMonth.add(incomeForCurrentDate);
    }

    return dailyIncomesForMonth;
  }

  Map<IncomeLine, double> calculateCollectionMethodTotals() {
    Map<IncomeLine, double> collectionMethodsTotals = {};

    for (var income in _incomes.value) {
      income.lines.forEach(
        (method) {
          collectionMethodsTotals.update(
            method,
            (value) => value + method.amount,
            ifAbsent: () => method.amount,
          );
        },
      );
    }
    return collectionMethodsTotals;
  }

  void dispose() {
    _logger.info('Disposing DailyIncomeController');
    _incomes.close();
    _totalIncome.close();
  }
}
