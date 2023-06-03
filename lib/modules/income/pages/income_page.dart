import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/setup/router.gr.dart';
import 'package:flutter/material.dart';
import '../widgets/income_chart.dart';
import '../widgets/income_filters.dart';
import '../widgets/income_panel.dart';
import '../widgets/income_collection_methods_charts.dart';

@RoutePage()
class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresos diarios'),
        elevation: 0,
      ),
      body: Row(
        children: [
          const NavigationPanel(),
          Expanded(
            child: Column(
              children: [
                IncomeFilters(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            IncomeChart(),
                            IncomeCollectionMethodsPieChart(),
                          ],
                        ),
                      ),
                      IncomePanel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationPanel extends StatefulWidget {
  const NavigationPanel({super.key});

  @override
  _NavigationPanelState createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
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
          navigationItem('Gastos', Icons.shopping_cart, () {}),
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
