import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_navigation_panel.dart';

@RoutePage()
class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gastos'),
        elevation: 0,
      ),
      body: const Row(
        children: [
          AppNavigationPanel(),
        ],
      ),
    );
  }
}
