import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../../../controllers/daily_income_controller.dart';
import '../../../../setup/get_it_setup.dart';
import '../../../widgets/app_stream_builder.dart';

class DailyIncomeBranchFilter extends StatelessWidget {
  final _controller = getIt<DailyIncomeController>();
  final _logger = Logger('DailyIncomeBranchFilter');

  DailyIncomeBranchFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeBranchFilter');
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Text('Sucursal'),
            const SizedBox(width: 10),
            AppStreamBuilder<String>(
              stream: _controller.selectedBranch,
              onData: (branch) => _buildDropdownButton(branch),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _buildDropdownButton(String branch) {
    _logger.info('Building DropdownButton with branch: $branch');
    return DropdownButton<String>(
      value: branch,
      onChanged: (String? newValue) {
        if (newValue != null) {
          _controller.filterByBranch(newValue);
          _logger.info('FilterByBranch changed to: $newValue');
        }
      },
      items: _generateBranchItems(),
    );
  }

  List<DropdownMenuItem<String>> _generateBranchItems() {
    _logger.info('Generating DropdownMenuItems');
    return <String>['All', 'Restaurante', 'Discoteca']
        .map<DropdownMenuItem<String>>(
          (String value) => _buildDropdownMenuItem(value),
        )
        .toList();
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    _logger.info('Building DropdownMenuItem with value: $value');
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }
}
