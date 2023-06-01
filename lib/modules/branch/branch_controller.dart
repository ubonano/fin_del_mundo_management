import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'branch.dart';
import 'helpers/branch_repository.dart';

class BranchController {
  final Logger _logger;
  final BranchRepository _repository;

  final _branchesController = BehaviorSubject<List<Branch>>();

  BranchController(this._logger, this._repository) {
    _load();
  }

  Stream<List<Branch>> get branches => _branchesController.stream;

  void _load() {
    _logger.info('Loading branches...');
    _repository.getAll().listen(
      (branches) {
        _branchesController.add(branches);
        _logger.info('Loaded ${branches.length} branches.');
      },
      onError: (error) {
        _logger.severe('Failed to load branches: $error');
      },
    );
  }

  Future<void> add(Branch branch) async {
    _logger.info('Adding branch: ${branch.name}...');
    try {
      await _repository.add(branch);
      _logger.info('Added branch: ${branch.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add branch: $error');
    }
  }

  Future<void> update(Branch branch) async {
    _logger.info('Updating branch: ${branch.id}...');
    try {
      await _repository.update(branch);
      _logger.info('Updated branch: ${branch.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update branch: $error');
    }
  }

  Future<void> delete(Branch branch) async {
    _logger.info('Deleting branch: ${branch.id}...');
    try {
      await _repository.delete(branch);
      _logger.info('Deleted branch: ${branch.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete branch: $error');
    }
  }

  void dispose() {
    _branchesController.close();
  }
}
