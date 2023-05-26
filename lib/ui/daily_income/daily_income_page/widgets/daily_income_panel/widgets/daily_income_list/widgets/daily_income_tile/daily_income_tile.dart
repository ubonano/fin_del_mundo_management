import 'package:flutter/material.dart';
import '../../../../../../../../../modules/income/income.dart';
import '../../../../../../../../widgets/app_actions_buttons.dart';
import '../../../../../../../../widgets/app_dialog_confirm.dart';
import 'widgets/daily_income_info.dart';
import 'widgets/daily_income_payment_methods_widget.dart';

class DailyIncomeTile extends StatelessWidget {
  final Income income;
  final Function(Income) onEdit;
  final Function(Income) onDelete;

  const DailyIncomeTile({
    Key? key,
    required this.income,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: _buildTile(context),
    );
  }

  Widget _buildTile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DailyIncomeInfo(income: income),
        const Spacer(),
        DailyIncomePaymentMethodsWidgets(income: income),
        AppActionsButton(
          onEdit: () => onEdit(income),
          onDelete: () => AppDialogConfirm.showDeleteDialyIncome(
            context,
            onPressed: () => onDelete(income),
          ),
        ),
      ],
    );
  }
}
