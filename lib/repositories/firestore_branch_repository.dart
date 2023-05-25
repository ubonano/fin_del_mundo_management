import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import '../models/branch.dart';
import '../utils/interfaces/branch_repository.dart';

class FirestoreBranchRepository implements BranchRepository {
  final Logger _logger;
  final CollectionReference _collection;

  FirestoreBranchRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('branches');

  @override
  Stream<List<Branch>> getAll() {
    _logger.info('Fetching branches...');
    return _collection.snapshots().map(
      (snapshot) {
        final branches =
            snapshot.docs.map((doc) => Branch.fromFirestore(doc)).toList();
        _logger.info('Finished fetching all branches');
        return branches;
      },
    );
  }

  @override
  Future<void> add(Branch branch) async {
    _logger.info('Adding branch: ${branch.name}...');
    await _collection
        .add(branch.toFirestore())
        .then((value) => _logger.info('Successfully added a branch'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a branch: $error');
        throw error;
      },
    );
    _logger.info('Added branch: ${branch.name}.');
  }

  @override
  Future<void> update(Branch branch) async {
    _logger.info('Updating branch with id: ${branch.id}...');
    await _collection.doc(branch.id).update(branch.toFirestore()).then(
      (value) {
        _logger.info('Successfully updated a branch with ID: [${branch.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a branch with ID: [${branch.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated branch with id: ${branch.id}.');
  }

  @override
  Future<void> delete(Branch branch) async {
    _logger.info('Deleting branch with id: ${branch.id}...');
    await _collection
        .doc(branch.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a branch'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a branch with ID: [${branch.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted branch with id: ${branch.id}.');
  }
}
