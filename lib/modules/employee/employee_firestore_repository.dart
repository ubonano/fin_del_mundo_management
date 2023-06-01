import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'employee.dart';
import 'helpers/employee_repository.dart';

class EmployeeFirestoreRepository implements EmployeeRepository {
  final Logger _logger;
  final CollectionReference _collection;

  EmployeeFirestoreRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('employees');

  @override
  Stream<List<Employee>> getAll() {
    _logger.info('Fetching employees...');
    return _collection.snapshots().map(
      (snapshot) {
        final employees =
            snapshot.docs.map((doc) => Employee.fromFirestore(doc)).toList();
        _logger.info('Finished fetching all employees');
        return employees;
      },
    );
  }

  @override
  Future<void> add(Employee employee) async {
    _logger.info('Adding employee: ${employee.name}...');
    await _collection
        .add(employee.toFirestore())
        .then((value) => _logger.info('Successfully added an employee'))
        .catchError(
      (error) {
        _logger.severe('Failed to add an employee: $error');
        throw error;
      },
    );
    _logger.info('Added employee: ${employee.name}.');
  }

  @override
  Future<void> update(Employee employee) async {
    _logger.info('Updating employee with id: ${employee.id}...');
    await _collection.doc(employee.id).update(employee.toFirestore()).then(
      (value) {
        _logger
            .info('Successfully updated an employee with ID: [${employee.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update an employee with ID: [${employee.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated employee with id: ${employee.id}.');
  }

  @override
  Future<void> delete(Employee employee) async {
    _logger.info('Deleting employee with id: ${employee.id}...');
    await _collection
        .doc(employee.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted an employee'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete an employee with ID: [${employee.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted employee with id: ${employee.id}.');
  }
}
