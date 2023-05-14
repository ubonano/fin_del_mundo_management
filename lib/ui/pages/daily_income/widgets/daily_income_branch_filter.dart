import 'package:flutter/material.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeBranchFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  DailyIncomeBranchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Sucursal'),
            const SizedBox(width: 10),
            AppStreamBuilder<String>(
              stream: _controller.selectedBranch,
              onData: (branch) {
                return DropdownButton<String>(
                  value: branch,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _controller.filterByBranch(newValue);
                    }
                  },
                  items: <String>['All', 'Restaurante', 'Discoteca']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
