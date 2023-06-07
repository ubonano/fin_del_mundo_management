import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'employee.dart';
import 'helpers/employee_repository.dart';

class EmployeeController {
  final Logger _logger;
  final EmployeeRepository _repository;

  final _employeesController = BehaviorSubject<List<Employee>>();

  EmployeeController(this._logger, this._repository) {
    _load();
  }

  Stream<List<Employee>> get $employees => _employeesController.stream;

  void _load() {
    _logger.info('Loading employees...');
    _repository.getAll().listen(
      (employees) {
        _employeesController.add(employees);
        _logger.info('Loaded ${employees.length} employees.');
      },
      onError: (error) {
        _logger.severe('Failed to load employees: $error');
      },
    );
  }

  Future<void> add(Employee employee) async {
    _logger.info('Adding employee: ${employee.name}...');
    try {
      await _repository.add(employee);
      _logger.info('Added employee: ${employee.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add employee: $error');
    }
  }

  Future<void> update(Employee employee) async {
    _logger.info('Updating employee: ${employee.id}...');
    try {
      await _repository.update(employee);
      _logger.info('Updated employee: ${employee.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update employee: $error');
    }
  }

  Future<void> delete(Employee employee) async {
    _logger.info('Deleting employee: ${employee.id}...');
    try {
      await _repository.delete(employee);
      _logger.info('Deleted employee: ${employee.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete employee: $error');
    }
  }

  void dispose() {
    _employeesController.close();
  }
}
