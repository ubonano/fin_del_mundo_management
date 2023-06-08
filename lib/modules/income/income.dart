import 'package:cloud_firestore/cloud_firestore.dart';
import '../branch/branch.dart';
import 'income_line.dart';

class Income {
  String id;
  DateTime date;
  Branch branch;
  double total;
  List<IncomeLine> lines;

  Income({
    required this.id,
    required this.date,
    required this.branch,
    required this.lines,
  }) : total = lines.fold(0, (prev, method) => prev + method.amount);

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
    List<IncomeLine>? incomeItems,
  }) {
    return Income(
      id: id ?? this.id,
      date: date ?? this.date,
      branch: branch ?? this.branch,
      lines: incomeItems ?? this.lines,
    );
  }

  factory Income.blank() =>
      Income(id: '', date: DateTime.now(), branch: Branch.blank(), lines: []);

  factory Income.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final incomeItems = List<IncomeLine>.from(
      data['lines'].map(
        (item) => IncomeLine.fromMap(item as Map<String, dynamic>),
      ),
    );

    return Income(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      branch: Branch(id: data['branchId'], name: data['branchName']),
      lines: incomeItems,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'date': Timestamp.fromDate(date),
        'branchId': branch.id,
        'branchName': branch.name,
        'lines': lines.map((item) => item.toMap()).toList(),
        'total': total,
      };
}
