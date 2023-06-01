import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import '../collection_method/utils/collection_method_item.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  List<CollectionMethodItem> collectionMethodItems;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.collectionMethodItems,
  }) : total = collectionMethodItems.fold(
            0, (prev, method) => prev + method.amount);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Income && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Income copyWith({
    String? id,
    DateTime? date,
    Branch? branch,
    double? total,
    List<CollectionMethodItem>? collectionMethodItems,
  }) {
    return Income(
      id: id ?? this.id,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      collectionMethodItems:
          collectionMethodItems ?? this.collectionMethodItems,
    );
  }

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final collectionItems = List<CollectionMethodItem>.from(
      data['collectionMethodItems'].map(
        (item) => CollectionMethodItem.fromMap(item as Map<String, dynamic>),
      ),
    );

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(id: data['branchId'], name: data['branchName']),
      collectionMethodItems: collectionItems,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'collectionMethodItems':
            collectionMethodItems.map((item) => item.toMap()).toList(),
        'total': total,
      };

  // double calculateTotal() => collectionMethods.values.reduce((a, b) => a + b);
}
