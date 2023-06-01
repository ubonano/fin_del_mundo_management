import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import '../collection_method/helpers/collection_item.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  List<CollectionItem> collectionItems;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.collectionItems,
  }) : total = collectionItems.fold(0, (prev, method) => prev + method.amount);

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
    List<CollectionItem>? collectionItems,
  }) {
    return Income(
      id: id ?? this.id,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      collectionItems: collectionItems ?? this.collectionItems,
    );
  }

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final collectionItems = List<CollectionItem>.from(
      data['collectionItems'].map(
        (item) => CollectionItem.fromMap(item as Map<String, dynamic>),
      ),
    );

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(id: data['branchId'], name: data['branchName']),
      collectionItems: collectionItems,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'collectionItems': collectionItems.map((item) => item.toMap()).toList(),
        'total': total,
      };
}
