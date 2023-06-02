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

void migrateData2() async {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  print('INIT MIGRATION');
  QuerySnapshot dailyIncomesSnapshot =
      await firestoreInstance.collection('dailyIncomes').get();

  dailyIncomesSnapshot.docs.forEach((doc) async {
    final data = doc.data() as Map<String, dynamic>;
    print('migration =: $data');
    String branchId = "";
    if (data['branch'] == "Discoteca") {
      branchId = "uEdiho4VWh0PgkbojfoW";
    } else if (data['branch'] == "Restaurante") {
      branchId = "VHoSIo5jxIcUVbfsEVcv";
    }

    int cashAmount =
        data['paymentMethods']['cash'] + data['surplus'] - data['shortage'];
    List<Map<String, dynamic>> collectionItems = [
      {'name': 'Efectivo', 'amount': cashAmount},
      {'name': 'Tarjetas', 'amount': data['paymentMethods']['cards']},
      {'name': 'Mercado Pago', 'amount': data['paymentMethods']['mercadoPago']},
    ];

    Map<String, dynamic> newData = {
      'branchId': branchId,
      'branchName': data['branch'],
      'collectionItems': collectionItems,
      'date': data['date'],
      'total': data['total'] + data['surplus'] - data['shortage'],
    };
    print('to =: $newData');
    await firestoreInstance.collection('incomesV3').add(newData);
    print('added!...');
  });
}
