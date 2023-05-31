import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  Map<String, double> collectionMethods;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.total,
    required this.collectionMethods,
  });

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
    Map<String, double>? collectionMethods,
    double? surplus,
    double? shortage,
  }) {
    return Income(
      id: id ?? this.id,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      total: total ?? this.total,
      collectionMethods: collectionMethods ?? this.collectionMethods,
    );
  }

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(id: data['branchId'], name: data['branchName']),
      total: data['total'],
      collectionMethods: Map<String, double>.from(data['collectionMethods']),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'collectionMethods': collectionMethods,
        'total': total,
      };

  double calculateTotal() => collectionMethods.values.reduce((a, b) => a + b);
}
