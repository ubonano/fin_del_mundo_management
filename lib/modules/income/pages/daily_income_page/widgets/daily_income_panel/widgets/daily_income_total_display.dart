import 'package:flutter/material.dart';

import '../../../../../../../setup/get_it_setup.dart';
import '../../../../../../../utils/app_formaters.dart';
import '../../../../../../../widgets/app_stream_builder.dart';
import '../../../../../income_controller.dart';

class DailyIncomeTotalDisplay extends StatelessWidget {
  final _controller = getIt<IncomeController>();

  DailyIncomeTotalDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<double>(
      stream: _controller.totalDailyIncome,
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
}
