import '../../branch/branch.dart';
import '../income.dart';

abstract class IncomeRepository {
  Stream<List<Income>> getAll();
  Stream<List<Income>> getByMonthAndYear(int month, int year);
  Stream<List<Income>> getByDateAndBranch(DateTime date, Branch branch);
  Future<void> add(Income income);
  Future<void> update(Income income);
  Future<void> delete(Income income);
}
