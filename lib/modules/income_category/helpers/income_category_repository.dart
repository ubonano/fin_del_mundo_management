import '../income_category.dart';

abstract class IncomeCategoryRepository {
  Stream<List<IncomeCategory>> getAll();
  Future<void> add(IncomeCategory incomeCategory);
  Future<void> update(IncomeCategory incomeCategory);
  Future<void> delete(IncomeCategory incomeCategory);
}
