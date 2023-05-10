import 'package:rxdart/rxdart.dart';
import '../models/daily_income.dart';
import '../setup/get_it_setup.dart';
import '../utils/interfaces/daily_income_repository.dart';

class DailyIncomeController {
  final _repository = getIt<DailyIncomeRepository>();
  final _incomes = BehaviorSubject<List<DailyIncome>>();

  Stream<List<DailyIncome>> get incomes => _incomes.stream;

  void loadIncomes() {
    _incomes.addStream(_repository.getAll());
  }

  Future<void> addIncome(DailyIncome income) async {
    await _repository.add(income);
    loadIncomes();
  }

  Future<void> updateIncome(DailyIncome income) async {
    await _repository.update(income);
    loadIncomes();
  }

  Future<void> deleteIncome(DailyIncome income) async {
    await _repository.delete(income);
    loadIncomes();
  }

  void dispose() {
    _incomes.close();
  }
}
