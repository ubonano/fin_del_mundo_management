import '../income_method.dart';

abstract class IncomeMethodRepository {
  Stream<List<IncomeMethod>> getAll();
  Future<void> add(IncomeMethod method);
  Future<void> update(IncomeMethod method);
  Future<void> delete(IncomeMethod method);
}
