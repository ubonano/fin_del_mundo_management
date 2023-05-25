import '../../models/employee.dart';

abstract class EmployeeRepository {
  Stream<List<Employee>> getAll();
  Future<void> add(Employee employee);
  Future<void> update(Employee employee);
  Future<void> delete(Employee employee);
}
