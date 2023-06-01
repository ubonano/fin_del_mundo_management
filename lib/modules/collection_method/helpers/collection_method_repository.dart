import '../collection_method.dart';

abstract class CollectionMethodRepository {
  Stream<List<CollectionMethod>> getAll();
  Future<void> add(CollectionMethod method);
  Future<void> update(CollectionMethod method);
  Future<void> delete(CollectionMethod method);
}
