import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../setup/router.gr.dart';

class AppNavigationPanel extends StatefulWidget {
  const AppNavigationPanel({super.key});

  @override
  _AppNavigationPanelState createState() => _AppNavigationPanelState();
}

class _AppNavigationPanelState extends State<AppNavigationPanel> {
  bool isCollapsed = true;

  StackRouter get router => AutoRouter.of(context);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 80 : 200,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          IconButton(
            icon: Icon(
              isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
          ),
          navigationItem('Dashboard', Icons.dashboard, () {}),
          navigationItem(
            'Ingresos',
            Icons.money,
            () => router.navigate(const IncomeRoute()),
          ),
          navigationItem(
            'Gastos',
            Icons.shopping_cart,
            () => router.navigate(const PaymentRoute()),
          ),
          navigationItem('Proveedores', Icons.local_shipping_rounded, () {}),
          navigationItem('Personal', Icons.person, () {}),
        ],
      ),
    );
  }

  Widget navigationItem(String title, IconData icon, VoidCallback onTap) {
    return Tooltip(
      message: title,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                isCollapsed ? '' : title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
