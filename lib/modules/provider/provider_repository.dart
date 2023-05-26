import 'provider.dart';

abstract class ProviderRepository {
  Stream<List<Provider>> getAll();
  Future<void> add(Provider provider);
  Future<void> update(Provider provider);
  Future<void> delete(Provider provider);
}
