import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import 'helpers/income_repository.dart';
import 'income.dart';

class IncomeFirestoreRepository implements IncomeRepository {
  late final CollectionReference _collection;

  IncomeFirestoreRepository(FirebaseFirestore instance) {
    _collection = instance.collection('incomesV3');
  }

  @override
  Stream<List<Income>> getAll() {
    return _collection.snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Income.fromFirestore(doc)).toList(),
        );
  }

  @override
  Stream<List<Income>> getByMonthAndYear(int month, int year) {
    final startDate = DateTime(year, month);
    final endDate = DateTime(year, month + 1);

    return _collection
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: endDate)
        .snapshots()
        .map(
          (query) =>
              query.docs.map((doc) => Income.fromFirestore(doc)).toList(),
        );
  }

  @override
  Stream<List<Income>> getByDateAndBranch(DateTime date, Branch branch) {
    final nextDay = DateTime(date.year, date.month, date.day + 1);

    return _collection
        .where('date', isGreaterThanOrEqualTo: date, isLessThan: nextDay)
        .where('branchId', isEqualTo: branch.id)
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => Income.fromFirestore(doc)).toList());
  }

  @override
  Future<void> add(Income income) {
    return _collection.add(income.toFirestore());
  }

  @override
  Future<void> update(Income income) {
    return _collection.doc(income.id).update(income.toFirestore());
  }

  @override
  Future<void> delete(Income income) {
    return _collection.doc(income.id).delete();
  }
}
