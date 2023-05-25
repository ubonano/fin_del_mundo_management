import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/utils/interfaces/collection_method_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../controllers/branch_controller.dart';
import '../controllers/collection_methods_controller.dart';
import '../controllers/daily_income_controller.dart';
import '../repositories/firestore_branch_repository.dart';
import '../repositories/firestore_collection_method_repository.dart';
import '../repositories/firestore_daily_income_repository.dart';
import '../utils/interfaces/branch_repository.dart';
import '../utils/interfaces/daily_income_repository.dart';

GetIt getIt = GetIt.instance;

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void setupServiceLocator() {
  _setupDailyIncomeInstances();
  _setupCollectionMethodInstance();
  _setupBranchInstance();
}

void _setupDailyIncomeInstances() {
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

void _setupCollectionMethodInstance() {
  getIt.registerLazySingleton<CollectionMethodRepository>(
    () => FirestoreCollectionMethodRepository(
      Logger('FirestoreCollectinMethodRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<CollectionMethodController>(
    () => CollectionMethodController(
      Logger('CollectionMethodController'),
      getIt<CollectionMethodRepository>(),
    ),
  );
}

void _setupBranchInstance() {
  getIt.registerLazySingleton<BranchRepository>(
    () => FirestoreBranchRepository(
      Logger('FirestoreBranchRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<BranchController>(
    () => BranchController(
      Logger('BranchController'),
      getIt<BranchRepository>(),
    ),
  );
}
