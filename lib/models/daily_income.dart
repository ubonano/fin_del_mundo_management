import 'package:cloud_firestore/cloud_firestore.dart';

class DailyIncome {
  final String id;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final String createdBy;
  final String modifiedBy;
  final DateTime date;
  final String branch;
  final double total;
  final Map<String, double> paymentMethods;
  final double surplus;
  final double shortage;

  DailyIncome({
    this.id = '',
    this.createdBy = '',
    this.modifiedBy = '',
    this.total = 0.0,
    required this.createdAt,
    required this.modifiedAt,
    required this.date,
    required this.paymentMethods,
    required this.surplus,
    required this.shortage,
    required this.branch,
  });

  double calculateTotal() =>
      paymentMethods.values.reduce((a, b) => a + b) + surplus - shortage;

  DailyIncome copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? modifiedAt,
    String? createdBy,
    String? modifiedBy,
    DateTime? date,
    String? branch,
    double? total,
    Map<String, double>? paymentMethods,
    double? surplus,
    double? shortage,
  }) {
    return DailyIncome(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      total: total ?? this.total,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      surplus: surplus ?? this.surplus,
      shortage: shortage ?? this.shortage,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'createdAt': createdAt,
      'modifiedAt': modifiedAt,
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'date': date,
      'branch': branch,
      'total': total,
      'paymentMethods': paymentMethods,
      'surplus': surplus,
      'shortage': shortage,
    };
  }

  factory DailyIncome.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return DailyIncome(
      id: doc.id,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      modifiedAt: (data['modifiedAt'] as Timestamp).toDate(),
      createdBy: data['createdBy'],
      modifiedBy: data['modifiedBy'],
      date: (data['date'] as Timestamp).toDate(),
      branch: data['branch'],
      total: data['total'],
      paymentMethods: Map<String, double>.from(data['paymentMethods']),
      surplus: data['surplus'],
      shortage: data['shortage'],
    );
  }
}
