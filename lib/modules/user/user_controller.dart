import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import 'user.dart';
import 'user_repository.dart';

class UserController {
  final Logger _logger;
  final UserRepository _repository;

  final _usersController = BehaviorSubject<List<User>>();

  UserController(this._logger, this._repository) {
    _load();
  }

  Stream<List<User>> get users => _usersController.stream;

  void _load() {
    _logger.info('Loading users...');
    _repository.getAll().listen(
      (users) {
        _usersController.add(users);
        _logger.info('Loaded ${users.length} users.');
      },
      onError: (error) {
        _logger.severe('Failed to load users: $error');
      },
    );
  }

  Future<void> add(User user) async {
    _logger.info('Adding user: ${user.name}...');
    try {
      await _repository.add(user);
      _logger.info('Added user: ${user.name}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to add user: $error');
    }
  }

  Future<void> update(User user) async {
    _logger.info('Updating user: ${user.id}...');
    try {
      await _repository.update(user);
      _logger.info('Updated user: ${user.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to update user: $error');
    }
  }

  Future<void> delete(User user) async {
    _logger.info('Deleting user: ${user.id}...');
    try {
      await _repository.delete(user);
      _logger.info('Deleted user: ${user.id}.');
      _load();
    } catch (error) {
      _logger.severe('Failed to delete user: $error');
    }
  }

  void dispose() {
    _usersController.close();
  }
}
