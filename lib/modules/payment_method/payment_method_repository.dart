import 'payment_method.dart';

abstract class PaymentMethodRepository {
  Stream<List<PaymentMethod>> getAll();
  Future<void> add(PaymentMethod paymentMethod);
  Future<void> update(PaymentMethod paymentMethod);
  Future<void> delete(PaymentMethod paymentMethod);
}
