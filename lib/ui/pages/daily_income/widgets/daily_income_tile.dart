import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import '../../../../models/daily_income.dart';
import '../../../../setup/router.gr.dart';
import 'daily_income_delete_icon_button.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}

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
      title: Text('${_getDateFormatted()} - \$${_getFormattedTotal()}'),
      subtitle: Text(widget.income.branch),
      onTap: () {
        _logger.info('Tile pressed for daily income: ${widget.income.id}');
        router?.push(DailyIncomeFormRoute(income: widget.income));
      },
      trailing: DailyIncomeDeleteIconButton(income: widget.income),
    );
  }

  String _getDateFormatted() {
    var formattedDate =
        DateFormat('EEEE dd-MM-yyyy', 'es_ES').format(widget.income.date);
    var day = formattedDate.split(' ')[0].inCaps;
    var date = formattedDate.split(' ').sublist(1).join(' ');

    return '$day $date';
  }

  String _getFormattedTotal() {
    final formatter = NumberFormat('#,###.00', 'es_AR');
    return formatter.format(widget.income.total);
  }
}
