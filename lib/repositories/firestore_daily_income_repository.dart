import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/daily_income.dart';
import '../utils/interfaces/daily_income_repository.dart';

class FirestoreDailyIncomeRepository implements DailyIncomeRepository {
  final _collection = FirebaseFirestore.instance.collection('dailyIncomes');

  @override
  Stream<List<DailyIncome>> getAll() {
    return _collection.snapshots().map((query) =>
        query.docs.map((doc) => DailyIncome.fromDocument(doc)).toList());
  }

  @override
  Future<void> add(DailyIncome income) {
    return _collection.add(income.toDocument());
  }

  @override
  Future<void> update(DailyIncome income) {
    return _collection.doc(income.id).update(income.toDocument());
  }

  @override
  Future<void> delete(DailyIncome income) {
    return _collection.doc(income.id).delete();
  }
}
