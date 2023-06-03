import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import 'income_item.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  List<IncomeItem> incomeItems;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.incomeItems,
  }) : total = incomeItems.fold(0, (prev, method) => prev + method.amount);

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
    List<IncomeItem>? incomeItems,
  }) {
    return Income(
      id: id ?? this.id,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      incomeItems: incomeItems ?? this.incomeItems,
    );
  }

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final incomeItems = List<IncomeItem>.from(
      data['incomeItems'].map(
        (item) => IncomeItem.fromMap(item as Map<String, dynamic>),
      ),
    );

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(id: data['branchId'], name: data['branchName']),
      incomeItems: incomeItems,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'incomeItems': incomeItems.map((item) => item.toMap()).toList(),
        'total': total,
      };
}
