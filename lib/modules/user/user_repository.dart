import 'user.dart';

abstract class UserRepository {
  Stream<List<User>> getAll();
  Future<void> add(User user);
  Future<void> update(User user);
  Future<void> delete(User user);
}
