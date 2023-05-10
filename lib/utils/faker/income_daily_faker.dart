import 'package:faker/faker.dart';

import '../../controllers/daily_income_controller.dart';
import '../../models/daily_income.dart';
import '../../setup/get_it_setup.dart';

void generateIncomes() {
  final controller = getIt<DailyIncomeController>();
  final faker = Faker();
  final branches = ['Discoteca', 'Restaurante'];
  final paymentMethods = ['Efectivo', 'Tarjetas', 'Mercado Pago'];

  for (var i = 1; i <= 30; i++) {
    for (var branch in branches) {
      Map<String, double> paymentMethodMap = {};
      for (var method in paymentMethods) {
        paymentMethodMap[method] =
            faker.randomGenerator.decimal() * 290000 + 10000;
      }

      var surplus = faker.randomGenerator.decimal() * 290000 + 10000;
      var shortage = faker.randomGenerator.decimal() * 290000 + 10000;

      var dailyIncome = DailyIncome(
        id: '',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        createdBy: 'User', // Reemplaza 'User' con el usuario actual
        modifiedBy: 'User', // Reemplaza 'User' con el usuario actual
        date: DateTime(2023, 4, i),
        branch: branch,
        total: paymentMethodMap.values.reduce((a, b) => a + b) +
            surplus -
            shortage,
        paymentMethods: paymentMethodMap,
        surplus: surplus,
        shortage: shortage,
      );

      controller.add(dailyIncome);
    }
  }
}
