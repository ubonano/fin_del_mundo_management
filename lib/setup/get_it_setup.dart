import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/utils/interfaces/collection_method_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../controllers/branch_controller.dart';
import '../controllers/collection_methods_controller.dart';
import '../controllers/daily_income_controller.dart';
import '../controllers/employee_controller.dart';
import '../controllers/payment_category.dart';
import '../controllers/payment_method_controller.dart';
import '../controllers/user_controller.dart';
import '../repositories/firestore_branch_repository.dart';
import '../repositories/firestore_collection_method_repository.dart';
import '../repositories/firestore_daily_income_repository.dart';
import '../repositories/firestore_employee_repository.dart';
import '../repositories/firestore_payment_category_repository.dart';
import '../repositories/firestore_payment_method.dart';
import '../repositories/firestore_user_repository.dart';
import '../utils/interfaces/branch_repository.dart';
import '../utils/interfaces/daily_income_repository.dart';
import '../utils/interfaces/employee_repository.dart';
import '../utils/interfaces/payment_category_repository.dart';
import '../utils/interfaces/payment_method.dart';
import '../utils/interfaces/user_repository.dart';

GetIt getIt = GetIt.instance;

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void setupServiceLocator() {
  _setupDailyIncomeInstances();
  _setupCollectionMethodInstance();
  _setupBranchInstance();
  _setupEmployeeInstance();
  _setupPaymentCategoryInstance();
  _setupPaymentMethodInstance();
  _setupUserInstance();
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

void _setupEmployeeInstance() {
  getIt.registerLazySingleton<EmployeeRepository>(
    () => FirestoreEmployeeRepository(
      Logger('FirestoreEmployeeRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<EmployeeController>(
    () => EmployeeController(
      Logger('EmployeeController'),
      getIt<EmployeeRepository>(),
    ),
  );
}

void _setupPaymentCategoryInstance() {
  getIt.registerLazySingleton<PaymentCategoryRepository>(
    () => FirestorePaymentCategoryRepository(
      Logger('FirestorePaymentCategoryRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<PaymentCategoryController>(
    () => PaymentCategoryController(
      Logger('PaymentCategoryController'),
      getIt<PaymentCategoryRepository>(),
    ),
  );
}

void _setupPaymentMethodInstance() {
  getIt.registerLazySingleton<PaymentMethodRepository>(
    () => FirestorePaymentMethodRepository(
      Logger('FirestorePaymentMethodRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<PaymentMethodController>(
    () => PaymentMethodController(
      Logger('PaymentMethodController'),
      getIt<PaymentMethodRepository>(),
    ),
  );
}

void _setupUserInstance() {
  getIt.registerLazySingleton<UserRepository>(
    () => FirestoreUserRepository(
      Logger('FirestoreUserRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<UserController>(
    () => UserController(
      Logger('UserController'),
      getIt<UserRepository>(),
    ),
  );
}
