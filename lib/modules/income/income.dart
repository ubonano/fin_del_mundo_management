import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import '../../models/user.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  Map<String, double> collectionMethods;
  User createdBy;
  DateTime createdAt;
  User modifiedBy;
  DateTime modifiedAt;

  final double surplus;
  final double shortage;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.total,
    required this.collectionMethods,
    required this.createdBy,
    required this.createdAt,
    required this.modifiedBy,
    required this.modifiedAt,
    this.surplus = 0.0,
    this.shortage = 0.0,
  });

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch.fromFirestore(data['branch']),
      total: data['total'],
      collectionMethods: Map<String, double>.from(data['collectionMethods']),
      createdBy: data['createdBy'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedBy: data['modifiedBy'],
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
    );
  }

  Income copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    User? createdBy,
    User? modifiedBy,
    DateTime? date,
    Branch? branch,
    double? total,
    Map<String, double>? collectionMethods,
    double? surplus,
    double? shortage,
  }) {
    return Income(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      total: total ?? this.total,
      collectionMethods: collectionMethods ?? this.collectionMethods,
      surplus: surplus ?? this.surplus,
      shortage: shortage ?? this.shortage,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'total': total,
        'collectionMethods': collectionMethods,
        'createdBy': createdBy.id,
        'createdAt': Timestamp.fromDate(createdAt),
        'modifiedBy': modifiedBy.id,
        'modifiedAt': Timestamp.fromDate(modifiedAt),
      };

  double calculateTotal() => collectionMethods.values.reduce((a, b) => a + b);
}
