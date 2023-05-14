import '../../models/daily_income.dart';

abstract class DailyIncomeRepository {
  Stream<List<DailyIncome>> getAll();
  Stream<List<DailyIncome>> getByMonthAndYear(int month, int year);
  Future<void> add(DailyIncome income);
  Future<void> update(DailyIncome income);
  Future<void> delete(DailyIncome income);
}
