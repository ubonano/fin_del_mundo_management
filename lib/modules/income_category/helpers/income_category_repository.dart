import '../../branch/branch.dart';
import '../income_category.dart';

abstract class IncomeCategoryRepository {
  Stream<List<IncomeCategory>> getAll();
  Stream<List<IncomeCategory>> getByBranch(Branch branch);
  Future<void> add(IncomeCategory incomeCategory);
  Future<void> update(IncomeCategory incomeCategory);
  Future<void> delete(IncomeCategory incomeCategory);
}
