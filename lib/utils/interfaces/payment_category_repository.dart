import '../../models/payment_category.dart';

abstract class PaymentCategoryRepository {
  Stream<List<PaymentCategory>> getAll();
  Future<void> add(PaymentCategory paymentCategory);
  Future<void> update(PaymentCategory paymentCategory);
  Future<void> delete(PaymentCategory paymentCategory);
}
