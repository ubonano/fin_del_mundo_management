import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/router.gr.dart';
import '../../../../utils/app_formaters.dart';
import 'daily_income_delete_icon_button.dart';

class DailyIncomeTile extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeTile({Key? key, required this.income}) : super(key: key);

  @override
  State<DailyIncomeTile> createState() => _DailyIncomeTileState();
}

class _DailyIncomeTileState extends State<DailyIncomeTile> {
  final _logger = Logger('DailyIncomeTile');
  late StackRouter? router;

  @override
  void initState() {
    initializeDateFormatting('es_ES', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    router = AutoRouter.of(context);

    _logger.info('Building DailyIncomeTile for income id: ${widget.income.id}');

    return ListTile(
      title: Text(
          '${AppFormaters.getFormattedDate(widget.income.date)} - \$${AppFormaters.getFormattedTotal(widget.income.total)}'),
      subtitle: Text(widget.income.branch),
      onTap: () {
        _logger.info('Tile pressed for daily income: ${widget.income.id}');
        router?.push(DailyIncomeFormRoute(income: widget.income));
      },
      trailing: DailyIncomeDeleteIconButton(income: widget.income),
    );
  }
}
