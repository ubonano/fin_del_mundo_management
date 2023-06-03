import '../../branch/branch.dart';
import '../payment.dart';

abstract class PaymentRepository {
  Stream<List<Payment>> getAll();
  Stream<List<Payment>> getByMonthAndYear(int month, int year);
  Stream<List<Payment>> getByDateAndBranch(DateTime date, Branch branch);
  Future<void> add(Payment payment);
  Future<void> update(Payment payment);
  Future<void> delete(Payment payment);
}
