import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/app_date_time.dart';
import '../../modules/branch/branch.dart';

class CommonFiltersController {
  final Logger _logger;

  final _selectedBranch = BehaviorSubject<Branch>.seeded(Branch.all());
  final _selectedMonth =
      BehaviorSubject<String>.seeded(AppDateTime.currentMonth());
  final _selectedYear =
      BehaviorSubject<String>.seeded(DateTime.now().year.toString());

  CommonFiltersController(this._logger);

  Stream<Branch> get $selectedBranch => _selectedBranch.stream;
  Stream<String> get $selectedMonth => _selectedMonth.stream;
  Stream<String> get $selectedYear => _selectedYear.stream;

  Stream<List<String>> get $months =>
      Stream.value(AppDateTime.generateAllMonths());
  Stream<List<String>> get $years => Stream.value(AppDateTime.generateYears());

  Branch get selectedBranch => _selectedBranch.value;
  String get selectedMonth => _selectedMonth.value;
  String get selectedYear => _selectedYear.value;

  // En CommonFiltersController
  Stream<Map<String, dynamic>> get $combinedFilters =>
      Rx.combineLatest3<String, String, Branch, Map<String, dynamic>>(
        $selectedMonth,
        $selectedYear,
        $selectedBranch,
        (selectedMonth, selectedYear, selectedBranch) => {
          'month': selectedMonth,
          'year': selectedYear,
          'branch': selectedBranch
        },
      );

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

  void dispose() {
    _logger.info('Disposing IncomeFiltersController');
    _selectedBranch.close();
    _selectedYear.close();
    _selectedMonth.close();
  }
}
