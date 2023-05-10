import '../../models/daily_income.dart';

abstract class DailyIncomeRepository {
  Stream<List<DailyIncome>> getAll();
  Future<void> add(DailyIncome income);
  Future<void> update(DailyIncome income);
  Future<void> delete(DailyIncome income);
}
