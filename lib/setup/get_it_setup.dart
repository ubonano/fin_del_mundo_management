import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../controllers/daily_income_controller.dart';
import '../repositories/firestore_daily_income_repository.dart';
import '../utils/interfaces/daily_income_repository.dart';

GetIt getIt = GetIt.instance;

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void setupServiceLocator() {
  setupDailyIncomeInstances();
}

void setupDailyIncomeInstances() {
  getIt.registerLazySingleton<DailyIncomeRepository>(
    () => FirestoreDailyIncomeRepository(
      Logger('FirestoreDailyIncomeRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<DailyIncomeController>(
    () => DailyIncomeController(
      Logger('DailyIncomeController'),
      getIt<DailyIncomeRepository>(),
    ),
  );
}
