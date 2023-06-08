import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeMethod {
  String id;
  String name;

  IncomeMethod({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomeMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;

  factory IncomeMethod.blank() => IncomeMethod(id: '', name: '');

  factory IncomeMethod.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return IncomeMethod(
      id: doc.id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
      };
}
