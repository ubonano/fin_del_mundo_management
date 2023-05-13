import 'package:flutter/material.dart';

import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';

class BranchFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();

  BranchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text('Sucursal'),
          const SizedBox(width: 10),
          StreamBuilder<String>(
            stream: _controller.selectedBranch,
            initialData: 'All',
            builder: (context, snapshot) {
              return DropdownButton<String>(
                value: snapshot.data,
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
    );
  }
}
