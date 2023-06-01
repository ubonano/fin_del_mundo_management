import '../branch.dart';

abstract class BranchRepository {
  Stream<List<Branch>> getAll();
  Future<void> add(Branch branch);
  Future<void> update(Branch branch);
  Future<void> delete(Branch branch);
}
