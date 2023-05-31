import 'package:cloud_firestore/cloud_firestore.dart';

void migrateData() async {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final oldCollection = firestoreInstance.collection("dailyIncomes");
  final newCollection = firestoreInstance.collection("incomes");

  final querySnapshot = await oldCollection.get();

  for (var oldDoc in querySnapshot.docs) {
    var oldData = oldDoc.data();

    // Mapping old data to new data structure
    var newData = {
      'branchId': oldData['branch'] == 'Discoteca'
          ? 'uEdiho4VWh0PgkbojfoW'
          : 'VHoSIo5jxIcUVbfsEVcv',
      'branchName': oldData['branch'],
      'collectionMethods': {
        'cards': oldData['paymentMethods']['cards'],
        'cash': oldData['paymentMethods']['cash'] +
            oldData['surplus'] -
            oldData['shortage'],
        'mercadoPago': oldData['paymentMethods']['mercadoPago'],
      },
      'date': oldData['date'],
      'total': oldData['total'],
    };

    // Adding the mapped document to the new collection
    await newCollection.add(newData);
  }
}
