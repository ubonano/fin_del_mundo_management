import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';

import '../../../../../../../controllers/daily_income_controller.dart';
import '../../../../../../../models/daily_income.dart';
import '../../../../../../../setup/get_it_setup.dart';
import '../../../../../../../setup/router.gr.dart';
import '../../../../../../widgets/app_actions_buttons.dart';
import '../../../../../../widgets/app_dialog_confirm.dart';
import 'daily_income_info.dart';
import 'daily_income_payment_methods_widget.dart';

class DailyIncomeTile extends StatefulWidget {
  final DailyIncome income;

  const DailyIncomeTile({Key? key, required this.income}) : super(key: key);

  @override
  State<DailyIncomeTile> createState() => _DailyIncomeTileState();
}

class _DailyIncomeTileState extends State<DailyIncomeTile> {
  final _logger = Logger('DailyIncomeTile');
  final _controller = getIt<DailyIncomeController>();

  StackRouter? get router => AutoRouter.of(context);

  @override
  void initState() {
    initializeDateFormatting('es_ES', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _logger.info('Building DailyIncomeTile for income id: ${widget.income.id}');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0.45,
            blurRadius: 6,
          ),
        ],
      ),
      child: _buildTile(),
    );
  }

  Widget _buildTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DailyIncomeInfo(income: widget.income),
        const Spacer(),
        DailyIncomePaymentMethodsWidgets(income: widget.income),
        AppActionsButton(
          onEdit: _onSelectEdit,
          onDelete: _onSelectDelete,
        ),
      ],
    );
  }

  void _onSelectEdit() {
    router?.push(DailyIncomeFormRoute(income: widget.income));
  }

  void _onSelectDelete() {
    AppDialogConfirm.showDeleteDialyIncome(
      context,
      onPressed: () => _deleteIncome(),
    );
  }

  void _deleteIncome() {
    try {
      _controller.delete(widget.income);
      router?.pop();
    } catch (e) {
      _showSnackbar('Ocurrio un error...');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
