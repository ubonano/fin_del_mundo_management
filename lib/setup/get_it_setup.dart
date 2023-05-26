import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/modules/collection_method/collection_method_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../modules/branch/branch_controller.dart';
import '../modules/collection_method/collection_methods_controller.dart';
import '../modules/income/income_controller.dart';
import '../controllers/employee_controller.dart';
import '../controllers/payment_category.dart';
import '../controllers/payment_controller.dart';
import '../controllers/payment_method_controller.dart';
import '../controllers/provider_controller.dart';
import '../controllers/user_controller.dart';
import '../modules/branch/branch_firestore_repository.dart';
import '../modules/collection_method/collection_method_firestore_repository.dart';
import '../modules/income/income_firestore_repository.dart';
import '../repositories/firestore_employee_repository.dart';
import '../repositories/firestore_payment_category_repository.dart';
import '../repositories/firestore_payment_method_repository.dart';
import '../repositories/firestore_payment_repository.dart';
import '../repositories/firestore_provider_repository.dart';
import '../repositories/firestore_user_repository.dart';
import '../modules/branch/branch_repository.dart';
import '../modules/income/income_repository.dart';
import '../utils/interfaces/employee_repository.dart';
import '../utils/interfaces/payment_category_repository.dart';
import '../utils/interfaces/payment_method.dart';
import '../utils/interfaces/payment_repository.dart';
import '../utils/interfaces/provider_repository.dart';
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
  _setupProviderInstance();
  _setupPaymentInstance();
}

void _setupDailyIncomeInstances() {
  getIt.registerLazySingleton<IncomeRepository>(
    () => IncomeFirestoreRepository(_firebaseFirestore),
  );

  getIt.registerLazySingleton<IncomeController>(
    () => IncomeController(
      Logger('DailyIncomeController'),
      getIt<IncomeRepository>(),
    ),
  );
}

void _setupCollectionMethodInstance() {
  getIt.registerLazySingleton<CollectionMethodRepository>(
    () => CollectionMethodFirestoreRepository(
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
    () => BranchFirestoreRepository(
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

void _setupProviderInstance() {
  getIt.registerLazySingleton<ProviderRepository>(
    () => FirestoreProviderRepository(
      Logger('FirestoreProviderRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<ProviderController>(
    () => ProviderController(
      Logger('ProviderController'),
      getIt<ProviderRepository>(),
    ),
  );
}

void _setupPaymentInstance() {
  getIt.registerLazySingleton<PaymentRepository>(
    () => FirestorePaymentRepository(
      Logger('FirestorePaymentRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<PaymentController>(
    () => PaymentController(
      Logger('PaymentController'),
      getIt<PaymentRepository>(),
    ),
  );
}
