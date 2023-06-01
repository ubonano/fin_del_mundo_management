import '../payment.dart';

abstract class PaymentRepository {
  Stream<List<Payment>> getAll();
  Future<void> add(Payment payment);
  Future<void> update(Payment payment);
  Future<void> delete(Payment payment);
}
