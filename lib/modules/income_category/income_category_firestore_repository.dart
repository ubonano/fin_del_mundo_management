import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/modules/income_category/income_category.dart';
import 'helpers/income_category_repository.dart';

class IncomeCategoryFirestoreRepository implements IncomeCategoryRepository {
  final CollectionReference _collection;

  IncomeCategoryFirestoreRepository(FirebaseFirestore instance)
      : _collection = instance.collection('incomeCategories');

  @override
  Stream<List<IncomeCategory>> getAll() {
    return _collection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => IncomeCategory.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<void> add(IncomeCategory incomeCategory) async {
    await _collection.add(incomeCategory.toFirestore());
  }

  @override
  Future<void> update(IncomeCategory incomeCategory) async {
    await _collection
        .doc(incomeCategory.id)
        .update(incomeCategory.toFirestore());
  }

  @override
  Future<void> delete(IncomeCategory incomeCategory) async {
    await _collection.doc(incomeCategory.id).delete();
  }
}
