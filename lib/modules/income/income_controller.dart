import 'package:fin_del_mundo_management/modules/branch/branch.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import '../collection_method/utils/collection_method_item.dart';
import 'income.dart';
import '../../utils/app_date_time.dart';
import 'income_repository.dart';

class IncomeController {
  final Logger _logger;

  final IncomeRepository _repository;

  final _incomes = BehaviorSubject<List<Income>>();
  final _selectedBranch = BehaviorSubject<Branch>.seeded(Branch.all());

  late final _selectedMonth =
      BehaviorSubject<String>.seeded(AppDateTime.currentMonth());
  final _selectedYear =
      BehaviorSubject<String>.seeded(DateTime.now().year.toString());
  final _totalDailyIncome = BehaviorSubject<double>.seeded(0);

  IncomeController(this._logger, this._repository) {
    initializeDateFormatting('es_ES', null);
    _load();
  }

  Stream<List<Income>> get incomes => _incomes.stream;
  Stream<Branch> get selectedBranch => _selectedBranch.stream;
  Stream<String> get selectedMonth => _selectedMonth.stream;
  Stream<String> get selectedYear => _selectedYear.stream;
  Stream<double> get totalDailyIncome => _totalDailyIncome.stream;

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
    _logger.info('Loading incomes');

    Rx.combineLatest3<String, String, Branch, Map<String, dynamic>>(
      _selectedMonth.stream,
      _selectedYear.stream,
      _selectedBranch.stream,
      (selectedMonth, selectedYear, selectedBranch) => {
        'month': selectedMonth,
        'year': selectedYear,
        'branch': selectedBranch
      },
    ).listen((selected) {
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

          _totalDailyIncome.add(filteredData.fold(
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

  List<Income> fillDailyIncomesForCurrentMonth() {
    final year = int.parse(_selectedYear.value);
    final month = AppDateTime.monthNameToNumber(_selectedMonth.value);

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
          collectionMethodItems: [],
        ),
      );
      dailyIncomesForMonth.add(incomeForCurrentDate);
    }

    return dailyIncomesForMonth;
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

  Map<CollectionMethodItem, double> calculateCollectionMethodTotals() {
    Map<CollectionMethodItem, double> collectionMethodsTotals = {};

    for (var income in _incomes.value) {
      income.collectionMethodItems.forEach(
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
    _selectedBranch.close();
    _selectedYear.close();
    _selectedMonth.close();
    _totalDailyIncome.close();
  }
}
