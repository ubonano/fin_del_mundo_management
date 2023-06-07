import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../setup/get_it_setup.dart';
import '../../../setup/router.gr.dart';
import '../../../utils/app_formaters.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_stream_builder.dart';
import '../income_controller.dart';
import 'income_list.dart';

class IncomePanel extends StatelessWidget {
  final _controller = getIt<IncomeController>();
  late final StackRouter router;

  IncomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    return Expanded(
      child: AppBackgound(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBackgroundTitle(title: 'Total de ingresos'),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 22.5),
              child: _buildTop(),
            ),
            const IncomeList(),
          ],
        ),
      ),
    );
  }

  Row _buildTop() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTotalField(),
        _buildAddButton(),
      ],
    );
  }

  Widget _buildTotalField() {
    return AppStreamBuilder<double>(
      stream: _controller.$totalIncome,
      onData: (data) => Text(
        '\$ ${AppFormaters.getFormattedTotal(data)}',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xff8278A1),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton.icon(
      onPressed: () => router.push(IncomeFormRoute()),
      icon: const Icon(Icons.add, color: Colors.white, size: 18),
      label: const Text(
        'Nuevo ingreso',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff5E27FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
