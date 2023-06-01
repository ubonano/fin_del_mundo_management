import 'package:cloud_firestore/cloud_firestore.dart';
import 'branch.dart';
import 'helpers/branch_repository.dart';

class BranchFirestoreRepository implements BranchRepository {
  late final CollectionReference _collection;

  BranchFirestoreRepository(FirebaseFirestore instance)
      : _collection = instance.collection('branches');

  @override
  Stream<List<Branch>> getAll() {
    return _collection.snapshots().map(
          (snapshot) =>
              snapshot.docs.map((doc) => Branch.fromFirestore(doc)).toList(),
        );
  }

  @override
  Future<void> add(Branch branch) async {
    await _collection.add(branch.toFirestore());
  }

  @override
  Future<void> update(Branch branch) async {
    await _collection.doc(branch.id).update(branch.toFirestore());
  }

  @override
  Future<void> delete(Branch branch) async {
    await _collection.doc(branch.id).delete();
  }
}
