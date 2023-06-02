import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> setupEmulator({required bool useEmulator}) async {
  if (useEmulator) {
    FirebaseFirestore.instance.settings = const Settings(
      host: 'localhost:8080',
      sslEnabled: false,
      persistenceEnabled: true,
    );

    // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  }
}
