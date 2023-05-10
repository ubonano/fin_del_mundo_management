import 'package:get_it/get_it.dart';

import '../controllers/daily_income_controller.dart';
import '../repositories/firestore_daily_income_repository.dart';
import '../utils/interfaces/daily_income_repository.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<DailyIncomeRepository>(
    () => FirestoreDailyIncomeRepository(),
  );
  getIt.registerLazySingleton<DailyIncomeController>(
    () => DailyIncomeController(),
  );
}
