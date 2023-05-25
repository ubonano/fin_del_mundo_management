import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';

import '../models/user.dart';
import '../utils/interfaces/user_repository.dart';

class FirestoreUserRepository implements UserRepository {
  final Logger _logger;
  final CollectionReference _collection;

  FirestoreUserRepository(this._logger, FirebaseFirestore instance)
      : _collection = instance.collection('users');

  @override
  Stream<List<User>> getAll() {
    _logger.info('Fetching users...');
    return _collection.snapshots().map(
      (snapshot) {
        final users =
            snapshot.docs.map((doc) => User.fromFirestore(doc)).toList();
        _logger.info('Finished fetching all users');
        return users;
      },
    );
  }

  @override
  Future<void> add(User user) async {
    _logger.info('Adding user: ${user.name}...');
    await _collection
        .add(user.toFirestore())
        .then((value) => _logger.info('Successfully added a user'))
        .catchError(
      (error) {
        _logger.severe('Failed to add a user: $error');
        throw error;
      },
    );
    _logger.info('Added user: ${user.name}.');
  }

  @override
  Future<void> update(User user) async {
    _logger.info('Updating user with id: ${user.id}...');
    await _collection.doc(user.id).update(user.toFirestore()).then(
      (value) {
        _logger.info('Successfully updated a user with ID: [${user.id}]');
      },
    ).catchError(
      (error) {
        _logger.severe(
            'Failed to update a user with ID: [${user.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Updated user with id: ${user.id}.');
  }

  @override
  Future<void> delete(User user) async {
    _logger.info('Deleting user with id: ${user.id}...');
    await _collection
        .doc(user.id)
        .delete()
        .then((value) => _logger.info('Successfully deleted a user'))
        .catchError(
      (error) {
        _logger.severe(
            'Failed to delete a user with ID: [${user.id}]. Error: $error');
        throw error;
      },
    );
    _logger.info('Deleted user with id: ${user.id}.');
  }
}
