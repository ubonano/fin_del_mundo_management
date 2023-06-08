import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fin_del_mundo_management/modules/income_method/helpers/income_method_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

import '../modules/branch/branch_controller.dart';
import '../modules/income_method/income_method_controller.dart';
import '../modules/income/income_controller.dart';
import '../modules/employee/employee_controller.dart';
import '../modules/income_category/helpers/income_category_repository.dart';
import '../modules/income_category/income_category_controller.dart';
import '../modules/income_category/income_category_firestore_repository.dart';
import '../widgets/app_common_filters/common_filters_controller.dart';
import '../modules/payment_category/payment_category_controller.dart';
import '../modules/payment/payment_controller.dart';
import '../modules/payment_method/payment_method_controller.dart';
import '../modules/provider/provider_controller.dart';
import '../modules/user/user_controller.dart';
import '../modules/branch/branch_firestore_repository.dart';
import '../modules/income_method/income_method_firestore_repository.dart';
import '../modules/income/income_firestore_repository.dart';
import '../modules/employee/employee_firestore_repository.dart';
import '../modules/payment_category/payment_category_firestore_repository.dart';
import '../modules/payment_method/payment_method_firestore_repository.dart';
import '../modules/payment/payment_firestore_repository.dart';
import '../modules/provider/provider_firestore_repository.dart';
import '../modules/user/user_firestore_repository.dart';
import '../modules/branch/helpers/branch_repository.dart';
import '../modules/income/helpers/income_repository.dart';
import '../modules/employee/helpers/employee_repository.dart';
import '../modules/payment_category/helpers/payment_category_repository.dart';
import '../modules/payment_method/helpers/payment_method_repository.dart';
import '../modules/payment/helpers/payment_repository.dart';
import '../modules/provider/helpers/provider_repository.dart';
import '../modules/user/helpers/user_repository.dart';

GetIt getIt = GetIt.instance;

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

void setupServiceLocator() {
  _setupncomeInstances();
  _setupCollectionMethodInstance();
  _setupBranchInstance();
  _setupEmployeeInstance();
  _setupPaymentCategoryInstance();
  _setupPaymentMethodInstance();
  _setupUserInstance();
  _setupProviderInstance();
  _setupPaymentInstance();
  _setupIncomeCategoryInstance();
}

void _setupncomeInstances() {
  getIt.registerLazySingleton<IncomeRepository>(
    () => IncomeFirestoreRepository(_firebaseFirestore),
  );

  getIt.registerLazySingleton<IncomeController>(
    () => IncomeController(
      Logger('IncomeController'),
      getIt<IncomeRepository>(),
      getIt<CommonFiltersController>(),
    ),
  );

  getIt.registerLazySingleton<CommonFiltersController>(
    () => CommonFiltersController(Logger('IncomeFiltersController')),
  );
}

void _setupCollectionMethodInstance() {
  getIt.registerLazySingleton<IncomeMethodRepository>(
    () => IncomeMethodFirestoreRepository(
      Logger('FirestoreCollectinMethodRepository'),
      _firebaseFirestore,
    ),
  );

  getIt.registerLazySingleton<IncomeMethodController>(
    () => IncomeMethodController(
      Logger('CollectionMethodController'),
      getIt<IncomeMethodRepository>(),
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
    () => EmployeeFirestoreRepository(
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
    () => PaymentCategoryFirestoreRepository(
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
    () => PaymentMethodFirestoreRepository(
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
    () => UserFirestoreRepository(
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
    () => ProviderFirestoreRepository(
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
    () => PaymentFirestoreRepository(_firebaseFirestore),
  );

  getIt.registerLazySingleton<PaymentController>(
    () => PaymentController(
      Logger('PaymentController'),
      getIt<PaymentRepository>(),
      getIt<CommonFiltersController>(),
    ),
  );
}

void _setupIncomeCategoryInstance() {
  getIt.registerLazySingleton<IncomeCategoryRepository>(
    () => IncomeCategoryFirestoreRepository(_firebaseFirestore),
  );

  getIt.registerLazySingleton<IncomeCategoryController>(
    () => IncomeCategoryController(
      Logger('IncomeCategoryController'),
      getIt<IncomeCategoryRepository>(),
    ),
  );
}
